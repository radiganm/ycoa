// @file     FlyerProcessorImpl.groovy
// @author   Mac Radigan
// @version  $Id: FlyerProcessorImpl.groovy 99 2012-06-13 00:48:19Z mac.radigan $

package org.radigan.ycoa.flyer.impl

import java.util.List
import java.util.Map
import org.apache.log4j.Logger
import java.util.ServiceLoader
import java.lang.Iterable
import org.apache.commons.io.FileUtils
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.Date

import org.radigan.system.configuration.Configuration
import org.radigan.ycoa.process.service.Processor
import org.radigan.ycoa.service.ServiceFactory
import org.radigan.ycoa.service.DatabaseConnection
import org.radigan.ycoa.process.service.Recordset
import org.radigan.ycoa.flyer.service.FlyerStation
import groovy.lang.GroovyClassLoader

public class FlyerProcessorImpl extends Processor {
  protected static log = Logger.getLogger(FlyerProcessorImpl.class.getName())
  protected Configuration configuration = null
  protected ServiceFactory serviceFactory = ServiceFactory.getInstance()   
  protected Map<String,DatabaseConnection> connectionMap = null
  protected FlyerStation flyerStation = null
  protected GroovyClassLoader classloader = null
  protected String root = null
  protected ConfigObject flyerConfig = null
  protected String environment = null
  protected String module = "FlyerCreation"
  protected SimpleDateFormat sqlDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss") // 2003-09-24T13:55:00

  public FlyerProcessorImpl() {
  }

  @Override public void initialize() {
    environment = serviceFactory.getEnvironment()
    connectionMap = serviceFactory.getConnectionMap()
    configuration = Configuration.getInstance()
    root = configuration.getResourceManager().getRootDirectory()
    flyerConfig = configuration.getConfiguration(environment, new File("flyer.conf"))
    //log.info "CONFIG: ${flyerConfig}"
    connectionMap.each { server, connection ->
      def username = flyerConfig.authentication.username
      def password = flyerConfig.authentication.password
      connection.login(username, password)
    }
  }

  public String getName() {
    return "Flyer System"
  }

  public int getPriority() {
    return 10
  }

  public boolean processFlyer(String server, DatabaseConnection connection, int flyerId, String flyerName, String session, int year, Date updated) {
    def safeFlyerName = "NoName"
    if(flyerName) safeFlyerName = flyerName
    safeFlyerName = safeFlyerName.replaceAll("\\.","_")
    safeFlyerName = safeFlyerName.replaceAll("/","_")
    safeFlyerName = safeFlyerName.replaceAll("&","_")
    safeFlyerName = safeFlyerName.replaceAll(" ","_")
    safeFlyerName = safeFlyerName.replaceAll("#","_")
    safeFlyerName = safeFlyerName.replaceAll("@","_")
    safeFlyerName = safeFlyerName.replaceAll("-","_")
    //safeFlyerName = safeFlyerName.replaceAll("\\(","_")
    //safeFlyerName = safeFlyerName.replaceAll("\\)","_")
    //log.trace "processing flyer id# ${flyerId}"
    flyerStation = new FlyerStation(connection, new File(root))
    if(flyerConfig.simulation) flyerStation.setSimulation(true)
    def dataout = new File("${flyerConfig.filesystem.dataout}/${flyerConfig.filesystem.directory[server]}/Flyer/${year}/${session}")
    flyerStation.setDirectory(dataout)
    if(!dataout.exists()) dataout.mkdirs()
    for( reportSize in 1..10 ) {
      def filename = "flyer-${safeFlyerName}-${flyerId}-${reportSize}.xml"
      def file = new File("${dataout}/${filename}")
      def flyerSummary = "${year} ${session} id#${flyerId} size#${reportSize} - ${flyerName}"
      def processed = new Date(file.lastModified())
      if(!file.exists()) {
        log.info "creating:  ${flyerSummary}"
        def data = flyerStation.process(flyerId, reportSize)
        log.debug "writing file: ${file}"
        FileUtils.writeStringToFile(file, data)
      } else if(updated.compareTo(processed) > 0) {
        log.warn "updating:  ${flyerSummary} (replacing ${processed} copy with edits made on ${updated})"
        def data = flyerStation.process(flyerId, reportSize)
        log.debug "writing file: ${file}"
        FileUtils.writeStringToFile(file, data)
      } else {
        //log.trace "up to date:  ${flyerSummary}"
      }
    }
  }

  public boolean processFlyerList(String server, DatabaseConnection connection) {
    def sproc = "yy_flyer_GetFlyerList"
    //def parameters = ["Year":2012, "Semester":"Spring"]
    def parameters = [:]
    def result = connection.execute(module, sproc, parameters)
    result.each { record ->
      try {
        def updated = sqlDateFormat.parse(record['LastUpdated'])
        def year = 0
        if(record['FlyerYear']) year = record['FlyerYear']
        def session = "0"
        if(record['FlyerSession']) session = record['FlyerSession']
        processFlyer(server, connection, record['FlyerID'], record['FlyerName'], session, year, updated)
      } catch(e) {
        log.error "error processing flyerId#${record['FlyerID']} - ${record['FlyerName']} (${record['FlyerSession']} ${record['FlyerYear']}).  reason:  ${e.getMessage()}"
      }
    }
  }

  public void process() {
    connectionMap.each { server, connection ->
      log.info "[${server.padRight(4)}]  connecting to server '${server.toUpperCase()}'"
      try {
        processFlyerList(server, connection)
      } catch(e) { 
        log.debug "[${server.padRight(4)}]  connection to server '${server.toUpperCase()}' failed.  Reason:  ${e.getMessage()}"
      }
    }
  }

}

/* *EOF* */
