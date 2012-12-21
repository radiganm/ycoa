// @file     Xsp.groovy
// @author   Mac Radigan
// @version: $Id: Xsp.groovy 86 2012-04-13 10:47:31Z mac.radigan $

package org.radigan.system.utilities

import groovy.text.GStringTemplateEngine
import groovy.io.PlatformLineWriter

public class Xsp {

  protected GStringTemplateEngine engine = new GStringTemplateEngine()

  public Xsp() {
  }

  public String process(String xsp, Map binding) {
    def template = engine.createTemplate(xsp).make(binding)
    def stringWriter = new StringWriter()
    def platformLineWriter = new PlatformLineWriter(stringWriter)
    template.writeTo(platformLineWriter)
    platformLineWriter.flush()
    return stringWriter.toString()
  }

}

// *EOF*
