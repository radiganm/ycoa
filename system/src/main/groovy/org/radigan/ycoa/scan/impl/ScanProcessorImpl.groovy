// @file     ScanProcessorImpl.groovy
// @author   Mac Radigan
// @version  $Id: ScanProcessorImpl.groovy 94 2012-06-10 08:22:58Z mac.radigan $

package org.radigan.ycoa.scan.impl

import java.util.List
import java.util.Map
import org.apache.log4j.Logger
import java.util.ServiceLoader
import java.lang.Iterable

import org.radigan.system.configuration.Configuration
import org.radigan.ycoa.process.service.Processor
import org.radigan.ycoa.service.ServiceFactory
import org.radigan.ycoa.service.DatabaseConnection
import org.radigan.ycoa.process.service.Recordset
import org.radigan.ycoa.scan.service.ScanStation
import org.radigan.ycoa.scan.service.Scanner
import groovy.lang.GroovyClassLoader

public class ScanProcessorImpl extends Processor {
  protected static log = Logger.getLogger(ScanProcessorImpl.class.getName())
  protected Configuration configuration = null
  protected ServiceFactory serviceFactory = ServiceFactory.getInstance()   
  protected Map<String,DatabaseConnection> connectionMap = null
  protected ScanStation scanStation = null
  protected List<org.radigan.ycoa.scan.service.Scanner> scannerList = []
  protected GroovyClassLoader classloader = null
  protected String root = null
  protected ConfigObject scanConfig = null
  protected String environment = null

  public ScanProcessorImpl() {
  }

  @Override public void initialize() {
    environment = serviceFactory.getEnvironment()
    classloader = new GroovyClassLoader(getClass().getClassLoader())
    //classloader = new GroovyClassLoader(getClass().getClassLoader().getParent())
    //classloader = new GroovyClassLoader(getClass().getClassLoader().clone())
    //classloader = new GroovyClassLoader(getClass().getClassLoader().getSystemClassLoader())
    connectionMap = serviceFactory.getConnectionMap()
    configuration = Configuration.getInstance()
    root = configuration.getResourceManager().getRootDirectory()
    scanConfig = configuration.getConfiguration(environment, new File("scan.conf"))
    getScanners()
    //log.info "CONFIG: ${scanConfig}"
    def gravicFile = new File(scanConfig.filesystem.gravic)
    if(scanConfig.vmware.enabled) {
      def vmRunFile = new File(scanConfig.vmware.vmrun)
      def vmxFile = new File(scanConfig.vmware.vmx)
      def vmUsername = new scanConfig.vmware.username
      def vmPassword = new scanConfig.vmware.password
      def vmDataIn = new File(scanConfig.vmware.datain)
      def vmDataOut = new File(scanConfig.vmware.dataout)
      def vmDataTemp = new File(scanConfig.vmware.temp)
      def hostDataIn = new File(scanConfig.filesystem.datain)
      def hostDataOut = new File(scanConfig.filesystem.dataout)
      def hostDataTemp = new File(scanConfig.filesystem.temp)
      def vmware = new Vmware(vmxFile, vmUsername, vmPassword)
      vmware.mapPath(vmDataIn, hostDataIn)
      vmware.mapPath(vmDataOut, hostDataOut)
      vmware.mapPath(vmDataTemp, hostDataTemp)
      scanStation = new ScanStation(gravicFile, vmware)
      scanStation.mapPath(vmMappedPath)
    } else {
      scanStation = new ScanStation(gravicFile)
    }
    if(scanConfig.simulation) scanStation.setSimulation(true)
    connectionMap.each { server, connection ->
      def username = scanConfig.authentication.username
      def password = scanConfig.authentication.password
      connection.login(username, password)
    }
  }

  public String getName() {
    return "Scan System"
  }

  public int getPriority() {
    return 10
  }

  protected List<Scanner> getScanners() {
    if(!scannerList) {
      def providerList = ServiceLoader.load(org.radigan.ycoa.scan.service.Scanner.class)
      def initScannerList = []
      providerList.each() { scanner ->
        initScannerList << scanner
      }
      new File("${root}/modules/scan/scanners").eachFileRecurse { sourceFile ->
        log.info """Compiling ${sourceFile}"""
        try {
          if(sourceFile.getName().endsWith(".icr")) initScannerList << classloader.parseClass(sourceFile).newInstance()
        } catch(e) {
          log.error """Compilation failed.  Reason: ${e.getMessage()}"""
        }
      }
      initScannerList = initScannerList.sort{it.getPriority()}
      //initScannerList.findAll{!it.isDefault()}.each { scannerList << it }
      //initScannerList.findAll{it.isDefault()}.each { scannerList << it }
      scannerList = initScannerList.sort{it.getPriority()}
      scannerList.each { scanner ->
        log.info """Loaded module ${scanner.getName()} (priority ${scanner.getPriority()})"""
      }
      scannerList.each { scanner ->
        scanner.startup()
      }
    }
    return scannerList
  }


  public boolean processPermutations(String server, File imageFile) {
    def templateFileList = []
    new File("${root}/modules/scan/templates").eachFileRecurse { templateFile ->
      if(templateFile.getName().endsWith(".omr")) {
        templateFileList << templateFile
      }
    }
    for(Scanner scanner : scannerList) {
      for(File templateFile : templateFileList) {
        log.info "[${server.padRight(4)}]  processing OMR template ${templateFile}"
        def recordset = scanStation.process(templateFile, imageFile)
        if(!scanner.isEnabled()) {
          log.info "[${server.padRight(4)}]  evaluating ${scanner.getName()} - offline"
        } else if(!scanner.canDecode(recordset)) {
          log.info "[${server.padRight(4)}]  evaluating ${scanner.getName()} - cannot decode"
        } else if(!scanner.isValid(recordset)) {
          log.warn "[${server.padRight(4)}]  evaluating ${scanner.getName()} - able to decode, but the data integrity check failed"
        } else {
          log.info "[${server.padRight(4)}]  evaluating ${scanner.getName()} - able to decode"
          def directory = scanConfig.filesystem.directory[server]
          def archiveDirectory = new File("${scanConfig.filesystem.dataout}/${directory}")
          scanner.setDatabaseConnection(connectionMap[server])
          scanner.setArchiveDirectory(archiveDirectory)
          scanner.setReportDirectory(new File("${root}/modules/scan/reports"))
          scanner.setFileCollection(scanStation.getFileCollection())
          scanner.setTemplateFile(templateFile)
          recordset = scanner.parse(recordset)
          scanner.onProcess(recordset)
          scanner.onReport(recordset)
          scanner.onArchive(recordset)
          if(scanner.isDefault()) {
            scanStation.cleanup()
            return true
          }
        }
      }
    }
    scanStation.cleanup()
    return false
  }

  public void process() {
    connectionMap.each { server, connection ->
      def directory = scanConfig.filesystem.directory[server]
      def inputDirectory = new File("${scanConfig.filesystem.datain}/${directory}")
      def tempDirectory = new File("${scanConfig.filesystem.temp}/${directory}")
      scanStation.setDirectory(tempDirectory)
      log.info "[${server.padRight(4)}]  connecting to server '${server.toUpperCase()}'"
      inputDirectory.eachFileRecurse { imageFile ->
        if(scanStation.canDecode(imageFile)) {
          log.info "[${server.padRight(4)}]  processing input image ${imageFile}"
          if(!processPermutations(server, imageFile)) {
            log.error """[${server.padRight(4)}]  Unable to find suitable decoder for ${imageFile}"""
          }
          if(scanConfig.filesystem.deleteInput) {
            log.info """[${server.padRight(4)}]  deleting file ${imageFile}"""
            imageFile.delete()
          }
        }
      }
    }
  }

}

/* *EOF* */
