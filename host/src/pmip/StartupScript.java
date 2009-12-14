package pmip;

import static jedi.functional.Coercions.list;
import static jedi.functional.FunctionalPrimitives.join;

public class StartupScript {

    private final String path;
    private final String pmipScript;

    public StartupScript(String path, String pmipScript) {
        this.path = path;
        this.pmipScript = pmipScript;
    }

    public String toString() {
        return join(list(
            redirectStdOutToConsole(),
            mkdirIfRequired(path),
            chdir(path),
            setVersion(PMIP.getVersion()),
            definePluginCommand(),
            createSampleScriptIfRequired(pmipScript)
        ), "\n");
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

    private String mkdirIfRequired(String path) {
        return "Dir.mkdir('" + path + "') unless File.directory? '" + path + "'";
    }

    private String chdir(String path) {
        return "Dir.chdir('" + path + "')";
    }

    private String createSampleScriptIfRequired(String pmipScript) {
        return "File.open('" + pmipScript + "','w') {|f| f.puts \"puts 'Hello PMIP #{PMIP_HOST_VERSION}! - Please see http://code.google.com/p/pmip/ for full instructions and plugin helper bundles.'\" } unless File.exist?('" + pmipScript + "')";
    }

    private String setVersion(String version) {
        return "PMIP_HOST_VERSION = '" + version + "'";
    }

    private String definePluginCommand() {
        return join(list(
            "def plugin(name)\n",
            "  begin",
            "    puts \"\\nLoading plugin #{name}:\"",
            "    dir = Dir.pwd + \"/plugins/#{name}\"",
            "    $:.unshift dir unless $:.include?(dir)",
            "    load \"plugins/#{name}/init.rb\"",
            "  rescue => e",
            "    message = [e.message] + e.backtrace",
            "    puts \"\\nAn Error occured loading plugin:\n  #{message.join(\"\n  \")}\"",
            "  end",
            "end")
        , "\n");
    }
}
