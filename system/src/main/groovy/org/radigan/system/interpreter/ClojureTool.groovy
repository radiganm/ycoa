// @file     ClojureTool
// @author   Mac Radigan
// @version: $Id$

package org.radigan.system.interpreter

import org.radigan.system.tools.Tool
import org.radigan.system.utilities.Debug
import clojure.lang.RT
import clojure.lang.Var
import clojure.lang.Compiler
import javax.script.ScriptEngine
import javax.script.ScriptEngineManager

public class ClojureTool extends Tool {
  protected List<String> args = null

  public String getName() {
    return "clojure"
  }

  public String getDescription() {
    return "Runs the clojure interpreter."
  }

  public void initialize() {
    cli.usage = "${getName()} -f <filename> [-h]"
    cli.with {
        h longOpt: 'help',   'show usage information'
        g longOpt: 'debug',  'turn debugging on'
        f longOpt: 'file',   'file',  args:1, argName:'file', required:true
    }
  }

  @Override public int process(String[] args) {
    this.args = args.collect{it}[2..-1]
    opt = parse(args)
    if(!opt) return 1
    if(opt.help) { cli.usage(); return 1 }
    return run()
  }

  public int run() {
    def manager = new ScriptEngineManager()
    def engine = manager.getEngineByName("Clojure")
    def cljArgs = new String[this.args.size()]
    def index = 0
    args.each { cljArgs[index++] = it }
    engine.put("*command-line-args*", cljArgs)
    engine.put("args", cljArgs)
    engine.eval(new File(opt.f).text)
    //
    //clojure.lang.Compiler.loadFile(opt.f)
    //RT.loadResourceScript(opt.f)
    //Var foo = RT.var("user", "foo")
    //Object result = foo.invoke("A", "B")
    //Object result = foo.invoke("Hi", "there")
    //println result
    return 0
  }

}

/* *EOF* */
