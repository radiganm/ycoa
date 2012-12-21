package org.radigan.ycoa.osgi.daemon

import org.radigan.ycoa.osgi.service.Factory
import java.util.concurrent.TimeUnit

public class DaemonService {
  protected Factory factory = null
  //protected boolean active = false
  protected boolean active = true

  public DaemonService() {
  }

  public void setFactory(Factory factory) {
    this.factory = factory
    updateDaemon()
  }

  public void updateDaemon() {
    if(factory) {
      println "daemon located: ${factory.getClass().getName()}"
      if(active) {
        //factory.getDaemon().start()
        factory.getTestDaemon().start()
        println "daemon started"
      } else {
        //factory.getDaemon().stop()
        factory.getTestDaemon().stop()
        println "daemon stopped"
      }
    } else {
      println "ERROR:  Factory unavailable"
    }
  }

  public void start() {
    try {
      active = true
      updateDaemon()
    } catch(Exception e) {
      println "ERROR:  Unable to start daemon.  Reason:  ${e.getMessage()}"
    }
  }

  public void stop() {
    try {
      active = false
      updateDaemon()
    } catch(Exception e) {
      println "ERROR:  Unable to stop daemon.  Reason:  ${e.getMessage()}"
    }
  }

}
/* EOF */
