// @file     ScanStationPool.groovy
// @author   Mac Radigan
// @version  $Id: ScanStationPool.groovy 97 2012-06-12 08:57:03Z mac.radigan $

package org.radigan.ycoa.scan.service

import java.util.ArrayList
import org.apache.log4j.Logger
import org.radigan.ycoa.process.service.Recordset

public class ScanStationPool extends ArrayList<ScanStation> {
  private static log = Logger.getLogger(ScanStationPool.class)
  private ScanStation reference = null

  public ScanStationPool() {
    reference = new ScanStation()
  }

  public ScanStationPool(File executable) {
    reference = new ScanStation(executable)
  }

  public ScanStationPool(File executable, Vmware vmware) {
    reference = new ScanStation(executable, vmware)
  }

  public void setSimulation(boolean simulation) {
    reference.setSimulation(simulation)
  }

  public void setDirectory(File tempDirectory) {
    reference.setDirectory(tempDirectory)
  }

  public Recordset process(File templateFile, File imageFile) {
    def scanStation = reference.clone()
    def recordset = scanStation.process(templateFile, imageFile)
    add(scanStation)
    return recordset
  }

  public void cleanup() {
    this.each { scanStation ->
      scanStation.cleanup()
    }
    clear()
  }

}

// *EOF*
