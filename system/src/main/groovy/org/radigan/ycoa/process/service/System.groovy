// @file     System.groovy
// @author   Mac Radigan
// @version  $Id: System.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.ycoa.process.service

public abstract class System implements Runnable {
  public abstract String getName()
  public abstract int getPriority()
  public abstract void run()
}

/* *EOF* */
