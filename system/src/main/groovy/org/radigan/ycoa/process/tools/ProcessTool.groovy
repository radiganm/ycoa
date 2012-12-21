// @file     PRocessTool.groovy
// @author   Mac Radigan
// @version: $Id: ProcessTool.groovy 71 2012-04-03 05:26:55Z mac.radigan $

package org.radigan.ycoa.process.tools

import org.radigan.system.tools.Tool
import org.radigan.ycoa.scan.service.*
import org.radigan.ycoa.service.ServiceFactory

public class ProcessTool extends Tool {

  public String getName() {
    return "process"
  }

  public String getDescription() {
    return "Runs the processor"
  }

  public void initialize() {
    cli.usage = "${getName()} -f <filename> [-h]"
    cli.with {
        h longOpt: 'help',        'show usage information'
        g longOpt: 'debug',       'turn debugging on'
        d longOpt: 'daemon',      'daemon'
        s longOpt: 'start',       'start', required:true
    }
  }

  public int run() {
    try {
      def serviceFactory = ServiceFactory.getInstance()
      if(opt.d) {
        serviceFactory.getDaemon().startAndWaitForInput()
      } else {
        serviceFactory.getSerialSystem().run()
      }
      return 0
    } catch(Exception e) {
      e.printStackTrace()
      return 1
    }
  }

}

/* *EOF* */
