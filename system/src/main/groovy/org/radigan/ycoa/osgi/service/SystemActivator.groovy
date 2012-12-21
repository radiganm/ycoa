package org.radigan.ycoa.osgi.service

import org.radigan.ycoa.service.ServiceFactory
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

public class SystemActivator implements BundleActivator {

  protected ServiceRegistration registration = null
  protected Factory factory = null

  public void start(BundleContext context) {
    try {
      factory = ServiceFactory.getInstance()
      if(factory) {
        println "registering ${Factory.class.getName()}"
        println "starting ${Factory.class.getName()} (from System)"
        factory.getDaemon().start()
      } else {
        println "ERROR:  unable to register ${Factory.class.getName()}"
      }
      def properties = new Properties()
      registration = context.registerService(Factory.class.getName(), factory, properties)
    } catch(Exception e) {
      e.printStackTrace()
    }
  }

  public void stop(BundleContext context) {
    try {
      if(factory) {
        factory.getDaemon().stop()
        factory = null
      }
      if(registration) {
        registration.unregister()
        registration = null
      }
    } catch(Exception e) {
      e.printStackTrace()
    }
  }

}
/* EOF */
