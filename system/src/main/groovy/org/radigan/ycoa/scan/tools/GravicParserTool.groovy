// @file     GravicParserTool
// @author   Mac Radigan
// @version: $Id: GravicParserTool.groovy 85 2012-04-13 08:51:12Z mac.radigan $

package org.radigan.ycoa.scan.tools

import org.radigan.system.tools.Tool
import org.radigan.ycoa.scan.service.*
import org.radigan.ycoa.process.service.*

public class GravicParserTool extends Tool {

  public String getName() {
    return "gravic-parser"
  }

  public String getDescription() {
    return "Parsers Gravic XML files."
  }

  public void initialize() {
    cli.usage = "${getName()} -f <filename> [-h]"
    cli.with {
        h longOpt: 'help',   'show usage information'
        g longOpt: 'debug',  'turn debugging on'
        p longOpt: 'parse',  'parse group by default pattern'
        f longOpt: 'file',   'file',  args:1, argName:'file', required:true
        s longOpt: 'short',  'short',  argName:'short'
    }
  }

  public int run() {
    def recordset = GravicParser.parse(new File(opt.f))
    //if(opt.p) recordset = recordset.groupBy("([A-z]+)([0-9]+)", 1, 2)
    if(opt.p) recordset = recordset.groupBy("([A-z]+)([0-9]+)", 1, 2).filter({r->return ((r["StudentID"]?.length()?:0)<=1) })
    if(opt.s) {
      println recordset.toShortString()
    } else {
      println recordset.toString()
    }
    return 0
  }

}

/* *EOF* */
