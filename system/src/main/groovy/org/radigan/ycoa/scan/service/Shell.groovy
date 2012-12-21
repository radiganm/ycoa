// @file     Shell.groovy
// @author   Mac Radigan
// @version  $Id$

package org.radigan.ycoa.scan.service

import org.apache.log4j.Logger;
import java.util.concurrent.ExecutionException
import org.radigan.system.configuration.Configuration
import org.apache.commons.io.FileUtils

public class Shell {
  protected static log = Logger.getLogger(Shell.class.getName())
  private long timeout = 0
  private long defaultTimeout = 4*60*1000

  public Shell() {
  }

  public Shell(Logger log) {
    this.log = log
  }

  public setLogger(Logger log) {
    this.log = log
  }

  public int execute(String command, long timeout=0) {
    try {
      def exitValue = 0
      def initialSize = 4096
      def outStream = new ByteArrayOutputStream(initialSize)
      def errStream = new ByteArrayOutputStream(initialSize)
      log.debug "[executing] ${commandLine}"
      def proc = commandLine.execute()
      proc.consumeProcessOutput(outStream, errStream)
      if(timeout) {
        proc.waitFor()
      } else {
        proc.waitForOrKill(defaultTimeout)
      }
      exitValue = proc.exitValue()
      if(exitValue) throw new ExecutionException("Command failed with exit code ${proc.exitValue()}.")
      return exitValue
    } catch(e) {
      log.debug """Error executing command ${command}.""", e
      throw new Exception("""Error running "${command}".""", e)
    }
  } 

}

/* *EOF* */
