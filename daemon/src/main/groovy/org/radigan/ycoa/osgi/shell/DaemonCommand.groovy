package org.radigan.ycoa.osgi.shell

import org.apache.felix.gogo.commands.Command
import org.apache.felix.gogo.commands.Option
import org.apache.karaf.shell.console.OsgiCommandSupport

@Command(scope = "ycoa", name = "daemon", description = "Daemon")
public class DaemonCommand  extends OsgiCommandSupport {
  @Option(name = "-r", aliases = [ "--restart" ], description = "restarts the daemon") private boolean restart
  @Option(name = "-h", aliases = [ "--halt" ], description = "halts the daemon") private boolean halt
  @Option(name = "-s", aliases = [ "--start" ], description = "starts the daemon") private boolean start

  @Override protected Object doExecute() throws Exception {
    println "DaemonCommand resart:${restart}, stop:${stop}, start:${start}"
  }
}
