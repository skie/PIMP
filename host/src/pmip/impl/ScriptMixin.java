package pmip.impl;

import static jedi.functional.FunctionalPrimitives.join;

public class ScriptMixin {

    static String singleQuote(String value) {
        return "'" + value + "'";
    }

    static String doubleQuote(String value) {
        return "\"" + value + "\"";
    }

    static String createScriptIfRequired(String scriptName, String script) {
        return "File.open(" + scriptName + ",'w') {|f| f.puts " + doubleQuote(script) + " } unless File.exist?(" + scriptName + ")";
    }

    static String mkdirIfRequired(String path) {
        return "Dir.mkdir(" + path + ") unless File.directory? " + path;
    }

    static String chdir(String path) {
        return "Dir.chdir(" + path + ")";
    }

    static String script(String... lines) {
        return join(lines, "\n");
    }
}
