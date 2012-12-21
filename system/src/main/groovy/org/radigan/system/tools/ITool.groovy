// @file     Tool
// @author   Mac Radigan
// @version: $Id$

package org.radigan.system.tools

import groovy.util.OptionAccessor

public interface ITool {
  public OptionAccessor parse(String[] args)
  public int process(String[] args)
  public void initialize()
  public String getName()
  public String getDescription()
  public int run()
}
