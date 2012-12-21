// @file     SerialSystem.groovy
// @author   Mac Radigan
// @version  $Id: SerialSystem.groovy 87 2012-05-22 16:08:29Z mac.radigan $

package org.radigan.ycoa.process.impl

import java.util.List
import java.util.ServiceLoader
import org.apache.log4j.Logger
import java.util.ServiceLoader
import java.lang.Iterable

import org.radigan.ycoa.process.service.System
import org.radigan.ycoa.process.service.Processor

public class SerialSystem extends System {
  protected static log = Logger.getLogger(SerialSystem.class)
  protected long batchId = 0
  protected List<org.radigan.ycoa.process.service.System> systemList = []

/*
  // ISSUE: instance conflicts with Script.run()
  public SerialSystem {
    initialize()
  }
  private void initialize() {
  }
*/

  @Override public String getName() {
    return "Serial Processor"
  }

  @Override public int getPriority() {
    return 10
  }

  @Override public void run() {
    batchId++
    try {
       if(!systemList) {
         def providerList = ServiceLoader.load(org.radigan.ycoa.process.service.Processor.class)
         providerList.each() { system ->
           systemList << system
         }
         if(!systemList.size()) { 
           // OSGi container can't access the SPI, so forcibly create references
           systemList << new org.radigan.ycoa.scan.impl.ScanProcessorImpl()
           //systemList << new org.radigan.ycoa.scan.impl.DefaultProcessorImpl()
         }
         systemList = systemList.sort{it.getPriority()}
         systemList.each { system ->
           log.info """Loaded module ${system.getName()} (priority ${system.getPriority()})"""
           system.initialize()
        }
      }
      log.info """Serial batch #${batchId} started"""
      systemList.each { system ->
        log.info """Running module ${system.getName()}"""
        system.process()
      }
      log.info """Serial batch complete"""
    } catch(e) {
      def endl = java.lang.System.getProperty("line.separator")
      def sb = new StringBuffer()
      sb << """Unable to load module.  Reason:  ${e.getMessage()}""" << endl
      e.getStackTrace().each { entry ->
        if(entry.toString().indexOf("closure")<0 && entry.toString().indexOf("(Unknown Source)")<0) {
          if(entry.getClassName().startsWith("org.radigan")) {
            sb << """  => ${entry.toString()}""" << endl
          } else {
            sb << """  -> ${entry.toString()}""" << endl
          }
        }
      }
      log.error """${sb.toString()}"""
    }
  }

}

/* *EOF* */
