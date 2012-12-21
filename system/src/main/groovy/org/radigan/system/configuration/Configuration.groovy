// @file     Configuration.groovy
// @author   Mac Radigan
// @version  $Id: Configuration.groovy 79 2012-04-04 07:46:41Z mac.radigan $

package org.radigan.system.configuration

import org.radigan.system.utilities.ResourceManager
import org.apache.log4j.xml.DOMConfigurator
import org.apache.log4j.PropertyConfigurator
import groovy.util.ConfigSlurper
import javax.naming.ConfigurationException

public class Configuration {

  public ConfigObject config
  protected static Configuration ref = null
  protected ResourceManager resourceManager = new ResourceManager()
  protected String environment = null
  protected List libPath
  protected List configPath
  protected List resPath
  protected List binPath
  protected List homePath
  protected String root

  private Configuration() {
    initialize()
  }

  public static Configuration getInstance() {
     if(null==ref) { ref = new Configuration() }
     return ref
  }

  public ResourceManager getResourceManager() {
     return resourceManager
  }

  private initialize() {
    root = resourceManager.getRootDirectory()
    homePath = ["./target", "./lib"]
    configPath = [".", "./config"]
    libPath = ["./lib"]
    binPath = ["./bin"]
    resPath = ["res/system"]
    def systemHome = System.getenv("SYSTEM_HOME") // added for OSGi support
    if(!systemHome) {
      install()
      configureExecutables()
    }
    configureClasspath()
    configureSettings()
    configureLogging()
  }

  private install() {
    resPath.each { path -> 
      resourceManager.extractResource("${path}", new File("${root}")) 
    }
  }

  private File searchPath(File file) {
    def result = null
    configPath.each { path -> 
      def testFile = new File("${root}/${path}/${file}")
      if(testFile.exists()) {
        result = testFile
        return
      }
    }
    return result
  }

  private configureLogging() {
    //def configFile = searchPath(new File("logging.xml"))
    def configFile = searchPath(new File("logging.properties"))
    try {
      //if(configFile) DOMConfigurator.configure(configFile.toURL())
      if(configFile) PropertyConfigurator.configure(configFile.toURL())
    } catch(Exception e) {
      e.printStackTrace()
    }
  }

  public ConfigObject getConfiguration(String environment, File file) {
    def configFile = searchPath(file)
    if(!configFile) throw new ConfigurationException("""Configuration file not found: "${file}".""")
    def configSlurper = null
    if(environment) {
      configSlurper = new ConfigSlurper(environment)
    } else {
      configSlurper = new ConfigSlurper()
    }
    configSlurper.classLoader = resourceManager.getClassLoader()
    return configSlurper.parse(configFile.toURL())
  }

  public static ConfigObject getConfiguration() {
    return getInstance().config
  }

  private configureSettings() {
    environment = System.getenv("MODUS_OPERANDI")
    config = getConfiguration(environment, new File("system.config"))
  }

  private configureClasspath() {
    libPath.each { path ->
      def dir = new File("${root}/${path}")
      if(dir.exists()) resourceManager.addClasspath(dir)
    }
  }

  private configureExecutables() {
    binPath.each { path ->
      new File("${root}/${path}").eachFileRecurse() { file ->
        if(file.canWrite()) file.setExecutable(true, false)
      }
    }
  }


}

// *EOF*
