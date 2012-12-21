// @file     Processor.groovy
// @author   Mac Radigan
// @version  $Id: Processor.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.ycoa.process.service

public abstract class Processor {
  public abstract String getName()
  public abstract int getPriority()
  public abstract void process()
  public abstract void initialize()
}

/* *EOF* */
