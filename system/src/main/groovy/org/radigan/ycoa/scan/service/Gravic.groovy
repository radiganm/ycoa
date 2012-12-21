// @file     Gravic.groovy
// @author   Mac Radigan
// @version  $Id: Gravic.groovy 96 2012-06-10 23:03:11Z mac.radigan $

package org.radigan.ycoa.scan.service

import org.apache.log4j.Logger;
import java.util.concurrent.ExecutionException
import org.radigan.system.configuration.Configuration
import org.apache.commons.io.FileUtils

public class Gravic {
  protected static log = Logger.getLogger(Gravic.class.getName())
  private File executable = new File("c:\\Program Files (x86)\\Gravic\\Remark Office OMR 7\\Roo70.exe")
  private long timeout = 0
  private String response = null
  private Vmware vmware = null
  private Shell shell = null
  private pathMap = []

  public Gravic() {
    initialize()
  }

  public void initialize() {
    shell = new Shell(log)
  }

  public setLogger(Logger log) {
    this.log = log
    shell.setLogger(log)
    if(vmware) vmware.setLogger(log)
  }

  public void mapPath(File guestPath, File hostPath) {
    pathMap[guestPath] = hostPath
  }

  public File mapPath(File hostPath) {
    File guestPath = hostPath
    pathMap.each{ newPath, base ->
      if("${hostPath}".startsWith("${base}") {
        guestPath =  new File(base.toURI().relativize(hostPath.toURI()).getPath())
        guestPath =  "${newPath}\\${guestPath}"
      }
    }
    return guestPath
  }

  public Gravic(File executable, Vmware vmware=null) {
    initialize()
    this.executable = executable
    this.vmware = vmware
    vmware.setLogger(log)
  }

  public Gravic(File executable, long timeout) {
    this.timeout = timeout
  }

  public File getExecutable() {
     return executable
  }

  public Vmware getVmware() {
     return vmware
  }

  public void setResponse(File resourcePath) {
    if(!resourcePath) {
      response = null
    } else {
      response = resourcePath.text
    }
  }

  public void setResponse(String resourcePath) {
    if(!resourcePath) {
      response = null
    } else {
      response = Configuration.getInstance().getResourceManager().getText(resourcePath)
    }
  }

  public void process(File reference, File image, File result) { 
    if(response) {
      result.write(response)
      return
    }
    try {
      if(result.exists()) {
        log.debug "deleting ${result}"
        FileUtils.forceDelete(result)
      }
      def exitValue = 0
      if(vmware) {
        def commandLine = """ ${executable} /H /Wh /E /T ${mapPath(reference)} /I ${mapPath(image)} /Oxml ${mapPath(result)} """
        vmware.execute(commandLine)
      } else {
        def commandLine = """ ${executable} /H /Wh /E /T ${reference} /I ${image} /Oxml ${result} """
        shell.execute(commandLine)
      }
      if(exitValue) throw new ExecutionException("Gravic failed with exit code ${exitValue}.")
    } catch(e) {
      log.debug "Error running Gravic.", e
      throw new Exception("Error running Gravic.", e)
    }
  } 

}

/* *EOF* */
