// @file     FlyerTool
// @author   Mac Radigan
// @version: $Id: FlyerTool.groovy 97 2012-06-12 08:57:03Z mac.radigan $

package org.radigan.ycoa.scan.tools

import org.radigan.system.tools.Tool
import org.radigan.ycoa.flyer.impl.FlyerProcessorImpl

public class FlyerTool extends Tool {

  public String getName() {
    return "flyer"
  }

  public String getDescription() {
    return "Runs Flyer Processor."
  }

  public void initialize() {
    cli.usage = "${getName()} -f <filename> [-h]"
    cli.with {
        h longOpt: 'help',        'show usage information'
        g longOpt: 'debug',       'turn debugging on'
    }
  }

  public int run() {
    try {
      def flyer = new FlyerProcessorImpl()
      flyer.initialize()
      flyer.process()
      return 0
    } catch(Exception e) {
      e.printStackTrace()
      return 1
    }
  }

}

/* *EOF* */
