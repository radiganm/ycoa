// @file     ScriptTool
// @author   Mac Radigan
// @version: $Id: ScriptTool.groovy 87 2012-05-22 16:08:29Z mac.radigan $

package org.radigan.system.interpreter

import org.radigan.system.tools.Tool
import org.apache.bsf.BSFManager
import org.apache.bsf.util.IOUtils
import org.radigan.system.utilities.Debug

public class ScriptTool extends Tool {

  public String getName() {
    return "script"
  }

  public String getDescription() {
    return "Runs the script interpreter."
  }

  public void initialize() {
    cli.usage = "${getName()} -f <filename> [-h]"
    cli.with {
        h longOpt: 'help',   'show usage information'
        g longOpt: 'debug',  'turn debugging on'
        f longOpt: 'file',   'file',  args:1, argName:'file', required:true
    }
  }

  public int run() {
    BSFManager.registerScriptingEngine("groovy", "org.codehaus.groovy.bsf.GroovyEngine", ["groovy", "gy", "g", "ycs"] as String[])
    //BSFManager.registerScriptingEngine("Clojure", "clojure.contrib.jsr223.ClojureScriptEngine", ["clojure", "clj", "j", "ycl"] as String[])
    //BSFManager.registerScriptingEngine("beanshell", "bsh.util.BeanShellBSFEngine", ["bean", "bsh"] as String[])
    //BSFManager.registerScriptingEngine ("jython", "org.apache.bsf.engines.jython.JythonEngine", ["python", "py"] as String[])
    def manager = new BSFManager()
    def debug = Debug.getInstance()
    debug.setEngine(manager)
    def language = manager.getLangFromFilename(opt.f)
    def script = IOUtils.getStringFromReader(new FileReader(opt.f))
    manager.exec(language, opt.f, 0, 0, script)
    return 0
  }

}

/* *EOF* */
