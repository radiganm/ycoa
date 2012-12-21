package org.radigan.ycoa.osgi.daemon

import org.radigan.ycoa.osgi.service.Factory
import java.util.concurrent.TimeUnit

import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceReference
import org.osgi.util.tracker.ServiceTracker

public class DaemonServiceTracker extends ServiceTracker {
  protected Factory factory = null
  protected DaemonService daemonService = null
  protected BundleContext bundleContext = null
  protected static String ref = "org.radigan.ycoa.osgi.service.Factory"
  //protected static String ref = Factory.class.getName()

  public DaemonServiceTracker(BundleContext bundleContext, ServiceTracker serviceTracker) {
    super(bundleContext, ref, null)
    this.daemonService = new DaemonService()
    this.bundleContext = bundleContext
    println "service tracker:  ${ref}"
  }

  @Override public Object addingService(ServiceReference serviceReference) {
    factory = (Factory)super.addingService(serviceReference)
    println "service added:  ${factory.getClass().getName()}"
    daemonService.setFactory(factory)
    //daemonService.start()
    return factory
  }

  @Override public void modifiedService(ServiceReference serviceReference, Object service) {
    super.modifiedService(serviceReference, service)
    factory = (Factory)bundleContext.getService(serviceReference) 
    println "service modified:  ${factory.getClass().getName()}"
    daemonService.setFactory(factory)
  }

  @Override public void removedService(ServiceReference serviceReference, Object service) {
    //factory = (Factory)service
    super.removedService(serviceReference, service)
    println "service removed"
    daemonService.setFactory(null)
    //bundleContext.ungetService(serviceReference)
  }

  @Override public void start() {
    //super.start()
    def serviceReference = bundleContext.getServiceReference(ref)
    if(serviceReference) factory = (Factory)bundleContext.getService(serviceReference)
    daemonService.setFactory(factory)
    daemonService.start()
  }

  @Override public void stop() {
    //super.stop()
    def serviceReference = bundleContext.getServiceReference(ref)
    if(serviceReference) factory = (Factory)bundleContext.getService(serviceReference)
    daemonService.setFactory(factory)
    daemonService.stop()
  }

}
/* EOF */
