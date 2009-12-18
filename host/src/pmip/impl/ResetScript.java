package pmip.impl;

import pmip.Interpreter;
import pmip.Script;
import static pmip.impl.ScriptMixin.*;

public class ResetScript implements Script {

    private static final String MISSING_PMIP_RB_SCRIPT = "puts 'Hello PMIP #{PMIP_HOST_VERSION}! - Please see http://code.google.com/p/pmip/ for full instructions and plugin helper bundles.'";

    private final String path;
    private final String pmipScript;

    public ResetScript(String path, String pmipScript) {
        this.path = path;
        this.pmipScript = pmipScript;
    }

    public void execute(Interpreter interpreter) {
        interpreter.eval(script(
            mkdirIfRequired(singleQuote(path)),
            chdir(singleQuote(path)),
            mkdirIfRequired(singleQuote(path + "/plugins")),
            createScriptIfRequired(singleQuote(pmipScript), MISSING_PMIP_RB_SCRIPT)
        ));
    }
}
