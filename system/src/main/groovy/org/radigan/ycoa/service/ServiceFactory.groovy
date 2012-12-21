// @file     ServiceFactory
// @author   Mac Radigan
// @version  $Id: ServiceFactory.groovy 87 2012-05-22 16:08:29Z mac.radigan $

package org.radigan.ycoa.service

import java.util.Map
import org.apache.log4j.Logger

import org.radigan.ycoa.osgi.service.Factory
import org.radigan.system.configuration.Configuration
import org.radigan.ycoa.process.service.Daemon
import org.radigan.ycoa.process.service.System
import org.radigan.ycoa.process.impl.SerialSystem
import org.radigan.ycoa.process.service.TestDaemon
import org.radigan.ycoa.process.impl.TestSystem
import com.thoughtworks.xstream.*
import com.thoughtworks.xstream.io.xml.DomDriver

public class ServiceFactory implements Factory {

  protected Map<String,DatabaseConnection> connectionMap = [:]
  protected Configuration configuration = null
  protected ConfigObject ycoaConfig = null
  protected String environment = null
  protected SerialSystem serialSystem = null
  protected Daemon daemon = null
  protected TestDaemon testDaemon = null
  protected static HOSTENV = "COMPUTERNAME"

  private static ServiceFactory ref = null
  private ServiceFactory() {
    initialize()
  }
  public static ServiceFactory getInstance() { 
    if(!ref) ref = new ServiceFactory() 
    return ref
  }

  private void initialize() {
    configuration = Configuration.getInstance()
    environment = java.lang.System.getenv(HOSTENV)
    ycoaConfig = configuration.getConfiguration(environment, new File("ycoa.conf"))
    initializeConnections()
  }

  public String getEnvironment() {
    return environment
  }

  private void initializeConnections() {
    def serverMap = ycoaConfig.server
    serverMap.each { server ->
      def host = server.value.hostname.toString()
      def port = server.value.port
      def enabled = server.value.enabled
      //def port = server.value.port.toString()
      //port = Integer.parseInt(port)
      if(enabled && !connectionMap[server.key]) connectionMap[server.key] = new DatabaseConnection(host, port)
    }
  }

  public ConfigObject getConfiguration() {
    return ycoaConfig
  }

  public Map<String,DatabaseConnection> getConnectionMap() {
    return connectionMap
  }

  public DatabaseConnection getConnection(String name) {
    return connectionMap[name]
  }

  public Logger getLogger(object) {
    return Logger.getLogger(object.class.getName())
  }

  public System getSerialSystem() {
    if(!serialSystem) serialSystem = new SerialSystem()
    return serialSystem
  }

  public Daemon getDaemon() {
    if(!daemon) daemon = new Daemon()
    return daemon
  }

  public TestDaemon getTestDaemon() {
    if(!testDaemon) testDaemon = new TestDaemon()
    return testDaemon
  }

  public void save(File file, Object object) {
    def xstream = new XStream()
    file.withOutputStream { ostream ->
      xstream.toXML(object, ostream)
    }
  }

  public Object load(File file) {
    def className = new XmlSlurper().parseText(file.text).name()
    def object = Class.forName(className)
    def xstream = new XStream()
    file.withInputStream { istream ->
      object = xstream.fromXML(istream)
    }
    return object
  }

  public void test() {
     println "testing..."
  }

}

/* *EOF* */
