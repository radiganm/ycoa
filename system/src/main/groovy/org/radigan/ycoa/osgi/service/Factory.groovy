// @file     ServiceFactory
// @author   Mac Radigan
// @version  $Id: Factory.groovy 79 2012-04-04 07:46:41Z mac.radigan $

package org.radigan.ycoa.osgi.service

import org.radigan.ycoa.process.service.Daemon

public interface Factory {
  public Daemon getDaemon()
  public void test()
}

/* *EOF* */
