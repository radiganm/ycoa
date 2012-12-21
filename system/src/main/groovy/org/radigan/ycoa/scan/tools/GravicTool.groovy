// @file     GravicTool
// @author   Mac Radigan
// @version: $Id: GravicTool.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.ycoa.scan.tools

import org.radigan.system.tools.Tool
import org.radigan.ycoa.scan.service.*

public class GravicTool extends Tool {

  public String getName() {
    return "gravic"
  }

  public String getDescription() {
    return "Runs Gravic."
  }

  public void initialize() {
    cli.usage = "${getName()} -f <filename> [-h]"
    cli.with {
        h longOpt: 'help',        'show usage information'
        g longOpt: 'debug',       'turn debugging on'
        f longOpt: 'file',        'file',  args:1, argName:'file', required:true
        r longOpt: 'reference',   'reference',  args:1, argName:'reference', required:true
        o longOpt: 'output',      'output',  args:1, argName:'output', required:true
    }
  }

  public int run() {
    try {
      def gravic = new Gravic()
      def inputFile = new File(opt.f)
      def referenceFile = new File(opt.r)
      def outputFile = new File(opt.o)
      gravic.process(referenceFile, inputFile, outputFile)
      return 0
    } catch(Exception e) {
      e.printStackTrace()
      return 1
    }
  }

}

/* *EOF* */
