package pmip.impl;

import org.jruby.embed.LocalVariableBehavior;
import org.jruby.embed.ScriptingContainer;
import org.jruby.embed.LocalContextScope;
import static org.jruby.embed.LocalContextScope.*;
import static org.jruby.embed.LocalVariableBehavior.*;
import org.jruby.javasupport.JavaEmbedUtils;
import pmip.Console;
import pmip.Interpreter;

public class JRubyInterpreter implements Interpreter {
    private final Console console;
    private ScriptingContainer container;

    public JRubyInterpreter(Console console) {
        this.console = console;
        init();
    }

    public void reset() {
        init();
    }

    public void eval(String script) {
        try {
            container.runScriptlet(script);
        } catch (Exception e) {
            console.error("\nAn error occured while evaluating the script:");
            console.error("\n----------------------------------------------------------------------------\n");
            console.error(script);
            console.error("\n----------------------------------------------------------------------------\n");
            console.error("The error was: " + e.getMessage());
            for (StackTraceElement stackTraceElement : e.getStackTrace()) {
                console.error("\n  " + stackTraceElement);                
            }
            console.error("\n----------------------------------------------------------------------------\n");
        }
    }

    private void init() {
        //http://www.nabble.com/Call-for-discussion-about-embed-API-tc24528478.html
        //http://yokolet.blogspot.com/2009/08/redbridge-and-jruby-embed-api-update.html
        //http://wiki.trialox.org/confluence/display/DEV/Using+JRuby+in+OSGi
        //http://kenai.com/projects/jruby-embed/pages/Home
        try {
            ClassLoader oldClassLoader = Thread.currentThread().getContextClassLoader();
            Thread.currentThread().setContextClassLoader(null);
            container = new ScriptingContainer();
            container.put("$console", console);
            Thread.currentThread().setContextClassLoader(oldClassLoader);

        } catch (Exception e) {
            console.error("Unable to start jruby engine: " + e.getMessage());
            for (int i = 0; i < e.getStackTrace().length; i++) {
                console.error("\n" + e.getStackTrace()[i]);
            }
            throw new RuntimeException(e);
        }
    }
}
