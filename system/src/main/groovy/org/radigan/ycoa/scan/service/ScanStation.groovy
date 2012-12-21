// @file     ScanStation.groovy
// @author   Mac Radigan
// @version  $Id: ScanStation.groovy 96 2012-06-10 23:03:11Z mac.radigan $

package org.radigan.ycoa.scan.service

import org.apache.log4j.Logger
import java.util.List
import java.util.Map
import java.lang.IllegalArgumentException

import org.radigan.ycoa.service.ServiceFactory
import org.radigan.ycoa.process.service.Recordset
import org.radigan.ycoa.scan.service.Gravic
import org.radigan.ycoa.scan.service.GravicParser
import org.radigan.ycoa.process.service.FileCollection

public class ScanStation {
  protected static log = Logger.getLogger(ScanStation.class.getName())
  protected Gravic gravic = null
  protected GravicParser = new GravicParser()
  protected boolean simulation = false
  protected File directory = new File("GRAVIC-OUT")
  protected FileCollection fileCollection = null
  protected String supported = "xml|tif|pdf"
  protected boolean deleteInput = false
  protected Recordset recordset = null

  public ScanStation(File executable) {
    gravic = new Gravic(executable)
    initialize()
  }

  public ScanStation(File executable, Vmware vmware) {
    gravic = new Gravic(executable, vmware)
    initialize()
  }

  public ScanStation() {
    gravic = new Gravic()
    initialize()
  }

  public Object clone() {
    return new ScanStation(gravic.getExecutable(), gravic.getVmware())
  }

  private void initialize() {
  }

  public void setSimulation(boolean simulation) {
    this.simulation = simulation
  }

  public void setDeleteInput(boolean deleteInput) {
    this.deleteInput = deleteInput
  }

  public void setDirectory(File directory) {
    this.directory = directory
  }

  public boolean canDecode(imageFile) {
    return (imageFile.getName()=~/.*.($supported)/).matches()
  }

  public Recordset process(File templateFile, File imageFile, rotation=0) {
    recordset = null
    def imageId = null
    if(!fileCollection) {
      fileCollection = new FileCollection(directory)
      imageId = fileCollection.setPrimaryId(imageFile, false)
    } else {
      imageId = fileCollection.add(imageFile)
    }
    def rotationSuffix = rotation ? "-r${rotation}" : ""
    def gravicFilename = "gravic${rotationSuffix}.xml"
    def gravicXmlFile = fileCollection.updateFile(gravicFilename)
    //def extention = imageFile.getName().replaceFirst(~/\.[^\.]+$/, '')
    def extention = imageFile.getName().substring(imageFile.getName().indexOf(".")+1)
    if((imageFile.getName()=~/.*.($supported)/).matches()) {
      if(imageFile.getName().endsWith(".xml")) { 
        gravic.setResponse(imageFile)
      } else {
        gravic.setResponse(simulation ? "/res/data/gravic/signin-1.xml" : null)
      }
      gravic.process(templateFile, fileCollection[imageId], gravicXmlFile)
      //def recordset = GravicParser.parse(gravicXmlFile)
      recordset = GravicParser.parse(gravicXmlFile)
      fileCollection.updateFile(gravicFilename)
      return recordset
    } else {
      throw new IllegalArgumentException("""Unknown file extention for file "${imageFile}".""")
    }
  }

  public Recordset getRecordset() {
    return recordset
  }

  public FileCollection getFileCollection() {
    return fileCollection
  }

  public void cleanup() {
    fileCollection.cleanup()
    fileCollection = null
  }

}

/* *EOF* */
