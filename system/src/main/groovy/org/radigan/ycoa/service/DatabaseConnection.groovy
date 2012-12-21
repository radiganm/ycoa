// @file     Service
// @author   Mac Radigan
// @version  $Id: DatabaseConnection.groovy 97 2012-06-12 08:57:03Z mac.radigan $

package org.radigan.ycoa.service

import groovy.util.XmlSlurper
import groovy.util.slurpersupport.GPathResult
import org.radigan.ycoa.service.Connection
import org.apache.log4j.Logger
import groovy.xml.XmlUtil
import groovy.xml.StreamingMarkupBuilder
import java.net.URLEncoder
import org.radigan.ycoa.process.service.Recordset

public class DatabaseConnection {
  protected static log = Logger.getLogger(DatabaseConnection.class.getName())
  protected Connection connection = null

  public DatabaseConnection(String server, int port) {
    this.connection = new Connection(server, port)
    initialize()
  }

  public DatabaseConnection(DatabaseConnection databaseConnection) {
    this.connection = new Connection(databaseConnection.getConnection())
    initialize()
  }

  public Connection getConnection() {
    return connection
  }

  public int getPort() {
    return connection.getPort()
  }

  public String getUser() {
    return connection.getUser()
  }

  public String getPassword() {
    return connection.getPassword()
  }

  public String getServer() {
    return connection.getServer()
  }

  public void initialize() {
    GPathResult.metaClass.toString { ->
      def outputBuilder = new StreamingMarkupBuilder()
      def result = delegate
      def string = XmlUtil.serialize(outputBuilder.bind { mkp.yield result })
      return string
    }
    String.metaClass.encodeUrl = {
      URLEncoder.encode(delegate)
    }
  }

  public static String format(GPathResult result) {
    def outputBuilder = new StreamingMarkupBuilder()
    def string = XmlUtil.serialize(outputBuilder.bind { mkp.yield result })
    return string
  }

  public boolean login(String user, String password) throws Exception {
    try {
      connection.login(user, password)
    } catch(e) {
      throw new Exception("""Unable to connect.""", e)
    }
  }

  public String toString() {
    return connection.toString()
  }

  public String toUrl(String module, String storedProcedure, Map parameters) {
    def sb = new StringBuffer()
    sb << "/service.asp"
    sb << "?module=${module}"
    sb << "&sproc=${storedProcedure}"
    parameters.each { key, value ->
      sb << "&${key}=${value.toString().encodeUrl()}"
    }
    return sb.toString()
  }

  public Recordset execute(String module, String storedProcedure, Map parameters) throws Exception {
    try {
      return DatabaseParser.parse(executeXml(module, storedProcedure, parameters))
    } catch(e) {
      log.debug("""Failed to execute stored procedure.""", e)
      throw new Exception("""Failed to execute stored procedure.""", e)
    } 
  }

  public GPathResult executeXml(String module, String storedProcedure, Map parameters) throws Exception {
    try {
      def url = toUrl(module, storedProcedure, parameters)
      def response = connection.webservice(url)
      //log.debug "RESPONSE> ${response}"
      return new XmlSlurper().parseText(response)
    } catch(e) {
      log.debug("""Failed to execute stored procedure.""", e)
      throw new Exception("""Failed to execute stored procedure.""", e)
    } 
  }

}
// *EOF*
