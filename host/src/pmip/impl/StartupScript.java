package pmip.impl;

import static jedi.functional.Coercions.list;
import static jedi.functional.FunctionalPrimitives.join;
import pmip.Interpreter;
import pmip.PMIP;
import pmip.Script;
import static pmip.impl.ScriptMixin.*;

public class StartupScript implements Script {

    private static final String MISSING_INIT_RB_SCRIPT = "#load 'lib/???.rb'\n\n#bind 'ctrl alt shift ?', ???Action.new";

    public void execute(Interpreter interpreter) {
        interpreter.eval(script(
            setVersion(PMIP.getVersion()),
            redirectStdOutToConsole(),
            definePluginCommand()
        ));
    }

    private String setVersion(String version) {
        return "PMIP_HOST_VERSION = " + singleQuote(version);
    }

    private String redirectStdOutToConsole() {
        return join(list(
            "orignal_stdout = $stdout",
            "class ConsoleRedirect",
            "  def write(value)",
            "    $console.print(value)",
            "  end",
            "end",
            "$stdout = ConsoleRedirect.new")
            , "\n");
    }

    private String definePluginCommand() {
        return join(list(
            "def plugin(name)\n",
            "  begin",
            "    puts \"\\nLoading plugin #{name}:\"",
            "    dir = Dir.pwd + \"/plugins/#{name}\"",
            "    $plugin = name",
            mkdirIfRequired("dir"),
            createScriptIfRequired("dir + " + singleQuote("/init.rb"), MISSING_INIT_RB_SCRIPT),
            mkdirIfRequired("dir + " + singleQuote("/lib")),
            "    $:.unshift dir unless $:.include?(dir)",
            "    load \"plugins/#{name}/init.rb\"",
            "  rescue => e",
            "    message = [e.message] + e.backtrace",
            "    puts \"\\nAn Error occured loading plugin:\n  #{message.join(\"\n  \")}\"",
            "  ensure",
            "    $plugin = nil",
            "  end",
            "end")
            , "\n");
    }
}
