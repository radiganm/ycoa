// @file     TestSystem.groovy
// @author   Mac Radigan
// @version  $Id$

package org.radigan.ycoa.process.impl

import org.apache.log4j.Logger

import org.radigan.ycoa.process.service.System

public class TestSystem extends System {
  protected static log = Logger.getLogger(TestSystem.class)
  protected long batchId = 0

/*
  // ISSUE: instance conflicts with Script.run()
  public TestSystem {
    initialize()
  }
  private void initialize() {
  }
*/

  @Override public String getName() {
    return "Test Processor"
  }

  @Override public int getPriority() {
    return 10
  }

  @Override public void run() {
    batchId++
    try {
      log.info """Test batch #${batchId} started"""
      log.info """Test batch complete"""
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
