// @file     VMWare.groovy
// @author   Mac Radigan
// @version  $Id$

package org.radigan.ycoa.scan.service

import org.apache.log4j.Logger;
import java.util.concurrent.ExecutionException
import org.radigan.system.configuration.Configuration
import org.apache.commons.io.FileUtils

public class Vmware {
  protected static log = Logger.getLogger(Vmware.class.getName())
  private String username = "Administrator"
  private String password = "password"
  private String hostname = "localhost"
  private File vmRun = new File("/Library/Application Support/VMware Fusion/vmrun")
  private File vmData = null
  private File dosCommand = new File("c:\\Windows\\System32\\cmd.exe")
  private long timeout = 0
  private Shell shell = null

  public Vmware() {
  }

  public setLogger(Logger log) {
    this.log = log
  }

  public VMware(File vmData, String username, String password) {
    this.vmData = vmData
    this.username = username
    this.password = password
  }

  public void setUsername(String username) {
    this.username = username
  }

  public void setTimeout(long timeout) {
    this.timeout = timeout
  }

  public void setPassword(String password) {
    this.password = password
  }

  public void setHostname(String hostname) {
    this.hostname = hostname
  }

  public void setVmData(File vmData) {
    this.vmData = vmData
  }

  public void setVmRun(File vmRun) {
    this.vmRun = vmRun
  }

  public void setDosCommand(File dosCommand) {
    this.dosCommand = dosCommand
  }

  public execute(String command) {
    try {
      def commandLine = """${vmrun} -T localhost -gu ${username} -gp ${password} runProgramInGuest ${vmData} -interactive ${dosCommand} /c ${command}"""
      def publicLine = """${vmrun} -T localhost -gu ${username} -gp **** runProgramInGuest ${vmData} -interactive ${dosCommand} /c ${command}"""

      log.debug "[executing] ${publicLine}"
      def exitValue = shell.execute()
      if(exitValue) throw new ExecutionException("VMWare vmrun failed with exit code ${proc.exitValue()}.")
    } catch(e) {
      log.debug "Error running VMWare.", e
      throw new Exception("Error running VMWare.", e)
    }
  } 

}

/* *EOF* */
