// @file     TestDaemon.groovy
// @author   Mac Radigan
// @version  $Id$

package org.radigan.ycoa.process.service

import org.radigan.ycoa.service.ServiceFactory
import org.radigan.ycoa.process.service.System
import java.util.concurrent.ScheduledThreadPoolExecutor
import java.util.concurrent.TimeUnit

import java.util.ServiceLoader
import org.apache.log4j.Logger

public class TestDaemon {
  private static log = Logger.getLogger(TestDaemon.class)
  private TimeUnit timeUnit = TimeUnit.SECONDS
  private long initialDelay = 0
  private long delay = 5
  private int threadPoolSize = 2
  private ScheduledThreadPoolExecutor executor = null
  private ServiceFactory serviceFactory = null
  private System system = null

  public TestDaemon() {
    initialize()
  }

  private initialize() {
    executor = new ScheduledThreadPoolExecutor(threadPoolSize)
    timeUnit = TimeUnit.SECONDS
    initialDelay = 0
    delay = 5
    serviceFactory = ServiceFactory.getInstance()
    system = serviceFactory.getTestSystem()
  }

  public void setInitialDelay(long initialDelay) {
    this.initialDelay = initialDelay
  }

  public void setDelay(long delay) {
    this.delay = delay
  }

  public void setTimeUnit(TimeUnit timeUnit) {
    this.timeUnit = timeUnit
  }

  public void startAndWaitForInput() {
    start()
    java.lang.System.in.readLines()
  }

  public void start() {
    //println """STDOUT> Starting daemon with thread pool size ${threadPoolSize}"""
    //println """STDOUT> Processing scheduled to occur at ${delay} ${timeUnit} intervals"""
    log.info """Starting daemon with thread pool size ${threadPoolSize}"""
    log.info """Processing scheduled to occur at ${delay} ${timeUnit} intervals"""
    executor.scheduleWithFixedDelay(system, initialDelay, delay, timeUnit)
  }

  public void stop() {
    executor.shutdown()
  }

}

/* *EOF* */
