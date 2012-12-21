// @file     Tool
// @author   Mac Radigan
// @version: $Id: Tool.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.system.tools

import groovy.util.CliBuilder
import groovy.util.OptionAccessor

public abstract class Tool implements ITool {
  public CliBuilder cli = new CliBuilder()
  public OptionAccessor opt = null
  public Tool() {
    initialize()
  }
  public OptionAccessor parse(String[] args) {
    opt = cli.parse(args as String[])
    return opt
  }
  public int process(String[] args) {
    opt = parse(args)
    if(!opt) return 1
    if(opt.help) { cli.usage(); return 1 }
    return run()
  }
  public abstract void initialize()
  public abstract String getName()
  public abstract String getDescription()
  public abstract int run()
}
