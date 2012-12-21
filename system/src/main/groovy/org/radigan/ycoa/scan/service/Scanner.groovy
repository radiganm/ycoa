// @file     Scanner.groovy
// @author   Mac Radigan
// @version  $Id: Scanner.groovy 99 2012-06-13 00:48:19Z mac.radigan $

package org.radigan.ycoa.scan.service

import org.apache.log4j.Logger
import groovy.util.AntBuilder
import org.radigan.system.utilities.Xsp
import org.radigan.ycoa.process.service.Recordset
import org.radigan.ycoa.process.service.FileCollection
import org.radigan.system.utilities.Md5
import org.radigan.ycoa.service.DatabaseConnection
import org.radigan.ycoa.service.DatabaseParser
import groovy.util.XmlSlurper
import groovy.util.slurpersupport.GPathResult
import org.apache.commons.io.FileUtils
import java.util.Date
import java.text.SimpleDateFormat
import java.util.TimeZone

public abstract class Scanner {
  protected static log = Logger.getLogger(Scanner.class.getName())
  protected String module = "Scan"
  protected String name = "Default"
  protected int priority = 1
  protected boolean enabled = true
  protected boolean consume = true
  //protected AntBuilder ant = new AntBuilder()
  protected Xsp xsp = new Xsp()
  protected File archiveDirectory = null
  protected File reportDirectory = null
  protected File templateFile = null
  protected FileCollection fileCollection = null
  protected DatabaseConnection databaseConnection = null

  public abstract boolean canDecode(Recordset recordset) 
  public abstract boolean isValid(Recordset recordset) 
  public Recordset parse(Recordset recordset) {
    return recordset
  }
  public void setArchiveDirectory(File archiveDirectory) {
    this.archiveDirectory = archiveDirectory
  }
  public void setReportDirectory(File reportDirectory) {
    this.reportDirectory = reportDirectory
  }
  public void setTemplateFile(File templateFile) {
    this.templateFile = templateFile
  }
  public void setDatabaseConnection(DatabaseConnection databaseConnection) {
    this.databaseConnection = databaseConnection
  }
  public void setFileCollection(FileCollection fileCollection) {
    this.fileCollection = fileCollection
  }
  public void onProcess(Recordset recordset) {
    //def parsedRecordset = parse(recordset)
    //process(parsedRecordset)
    process(recordset)
  }
  public void process(Recordset recordset) { }
  public void onArchive(Recordset recordset) {
    fileCollection.each { md5, sourceFile ->
      def filename = archive(sourceFile, md5, fileCollection.getCollectionId(), fileCollection.getUniqueId(), recordset)
      if(filename) {
        def archiveFile = new File("${archiveDirectory}/${filename}")
        archiveFile.getParentFile().mkdirs()
        //ant.copy(file:"${sourceFile}", toFile:"${archiveFile}")
        FileUtils.copyFile(sourceFile, archiveFile)
      }
    }
  }
  public File archive(File file, String md5, String collectionId, String uniqueId, Recordset recordset) { 
    return null 
  } 
  public void onReport(Recordset recordset) {
    //def parsedRecordset = parse(recordset)
    //report(parsedRecordset)
    report(recordset)
  } 
  public void report(Recordset recordset) { }
  public File createReport(File filename, File reportname, binding) { 
    def reportFile = new File("${reportDirectory}/${reportname}")
    def archiveFile = fileCollection.updateFile("${filename}")
    archiveFile << xsp.process(reportFile.text, binding)
    fileCollection.updateFile("${filename}")
    return archiveFile
  }
  public void startup() {}
  public void shutdown() {}
  public String getName() {
    return name
  }
  public int getPriority() {
    return priority
  }
  public boolean isEnabled() {
    return enabled
  }
  public boolean isDefault() {
    return consume
  }
  public String md5sum(String value) {
    return Md5.encode(value)
  }
  public Recordset execute(String storedProcedure, Map parameters) {
    return databaseConnection.execute(module, storedProcedure, parameters)
  }
  public GPathResult executeXml(String storedProcedure, Map parameters) {
    return databaseConnection.executeXml(module, storedProcedure, parameters)
  }
  public String toUrl(String storedProcedure, Map parameters) {
    return databaseConnection.toUrl(module, storedProcedure, parameters)
  }
  protected String getDate(String format="yyyy-MM-dd_kk-mm-ss", timezone="GMT") {
    def dateFormatter = new SimpleDateFormat(format)
    dateFormatter.setTimeZone(TimeZone.getTimeZone(timezone))
    def datetime = dateFormatter.format(new Date())
    return "${datetime}"
  }
  public static String format(GPathResult result) {
    return DatabaseConnection.format(result)
  }
}

/* *EOF* */
