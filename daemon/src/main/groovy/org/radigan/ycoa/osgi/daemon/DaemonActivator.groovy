package org.radigan.ycoa.osgi.daemon

import org.radigan.ycoa.osgi.service.Factory

import java.util.Properties
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceListener
import org.osgi.framework.ServiceEvent
import org.osgi.framework.ServiceRegistration
import org.osgi.framework.ServiceReference
import org.osgi.service.cm.ConfigurationAdmin
import org.osgi.service.cm.Configuration
import org.osgi.util.tracker.ServiceTracker

public class DaemonActivator implements BundleActivator {

  protected ServiceTracker serviceTracker = null
  protected DaemonServiceTracker daemonServiceTracker = null
  protected static String ref = "org.radigan.ycoa.osgi.service.Factory"
  //protected static String ref = Factory.class.getName()

  public DaemonActivator() {
    super()
  }

  public void start(BundleContext bundleContext) {
    try {
      serviceTracker = new ServiceTracker(bundleContext, ref, null)
      daemonServiceTracker = new DaemonServiceTracker(bundleContext, serviceTracker)
      daemonServiceTracker.open()
      //daemonServiceTracker.start()
      //daemonServiceTracker.waitForService(10000)
      /*
      def serviceReference = bundleContext.getServiceReference(ref)
      if(serviceReference) {
        def factory = (Factory)bundleContext.getService(serviceReference)
        if(factory) {
          factory.getDaemon().start()
        } else {
          println "ERROR:  Factory unavailable"
        }
      } else {
        println "ERROR:  Service reference unavailable"
      }
      */
    } catch(Exception e) {
      e.printStackTrace()
    }
  }

  public void stop(BundleContext bundleContext) {
    try {
      daemonServiceTracker.close()
      //daemonServiceTracker.stop()
      /*
      def serviceReference = bundleContext.getServiceReference(ref)
      if(serviceReference) {
        def factory = (Factory)bundleContext.getService(serviceReference)
        if(factory) {
          factory.getDaemon().stop()
        } else {
          println "ERROR:  Factory unavailable"
        }
      } else {
        println "ERROR:  Service reference unavailable"
      }
      */
    } catch(Exception e) {
      e.printStackTrace()
    }
  }

}
/* EOF */
