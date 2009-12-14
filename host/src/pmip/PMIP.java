package pmip;

import com.intellij.ide.plugins.PluginManager;
import com.intellij.openapi.application.ApplicationManager;
import com.intellij.openapi.components.ProjectComponent;
import com.intellij.openapi.fileEditor.FileDocumentManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.util.IconLoader;
import com.intellij.openapi.vfs.VirtualFileManager;
import com.intellij.openapi.wm.ToolWindow;
import com.intellij.openapi.wm.ToolWindowAnchor;
import com.intellij.openapi.wm.ToolWindowManager;
import org.jetbrains.annotations.NotNull;
import pmip.impl.BeanShellConsole;
import pmip.impl.JRubyInterpreter;
import static sugar.Sugar.filepath;

import javax.swing.*;
import java.awt.*;

import static jedi.functional.FunctionalPrimitives.join;

//TODO:
//- assign ctrl alt shift P to reset PMIP?
//- should redirect $stderr to error?

public class PMIP implements ProjectComponent {

    public static final String TOOLWINDOW_ID = "PMIP";

    private final Project project;
    private Console console;
    private Interpreter interpreter;

    public PMIP(Project project) {
        this.project = project;
    }

    public void initComponent() {
        console = new BeanShellConsole();
    }

    public void disposeComponent() {
        console.dispose();
    }

    @NotNull
    public String getComponentName() {
        return "PMIPConsole";
    }

    public void projectOpened() {
        initUI();
        resetInterpreter();
    }

    public void projectClosed() {
        toolWindowManager().unregisterToolWindow(TOOLWINDOW_ID);
    }

    //TODO: can this go - who calls it?
    public void expandPanel() {
        ToolWindow toolWindow = toolWindowManager().getToolWindow(TOOLWINDOW_ID);
        if (!toolWindow.isVisible()) {
            toolWindow.show(null);
        }
    }

    public static String getVersion() {
        return PluginManager.getPlugin(PluginManager.getPluginByClassName(PMIP.class.getName())).getVersion();
    }

    void resetInterpreter() {
        String path = project.getBaseDir().getPath() + "/pmip";
        String pmipScript = path + "/pmip.rb";

        if (interpreter == null) {
            interpreter = new JRubyInterpreter(console);
            interpreter.eval(new StartupScript(path, pmipScript).toString());
        } else {
            interpreter.reset();
        }
        bootPMIP(pmipScript);
    }

    private void initUI() {
        createToolWindow(createPanel(createToolBar()));
        console.init();
    }

    private void createToolWindow(JPanel panel) {
        ToolWindow toolwindow = toolWindowManager().registerToolWindow(TOOLWINDOW_ID, panel, ToolWindowAnchor.BOTTOM);
        toolwindow.setTitle("Console");
        toolwindow.setIcon(IconLoader.getIcon("/pmip.png"));
    }

    private JPanel createPanel(JToolBar toolbar) {
        JPanel panel = new JPanel(new BorderLayout());
        panel.add(console.getComponent(), BorderLayout.CENTER);
        panel.add(toolbar, BorderLayout.WEST);
        return panel;
    }

    private JToolBar createToolBar() {
        JToolBar toolbar = new JToolBar();
        toolbar.setOrientation(JToolBar.VERTICAL);
        toolbar.setFloatable(false);
        toolbar.add(new ResetPMIPAction(this));
        return toolbar;
    }

    private void bootPMIP(final String pmipScript) {
        ApplicationManager.getApplication().invokeLater(new Runnable() {
            public void run() {
                refreshFileSystem();
                loadPMIPScript(pmipScript);
            }
        });
    }

    private void refreshFileSystem() {
        FileDocumentManager.getInstance().saveAllDocuments();
        VirtualFileManager.getInstance().refreshWithoutFileWatcher(true);
    }

    private void loadPMIPScript(String pmipScript) {
        interpreter.eval(filepath(pmipScript).read());
        console.println("\nReady to go ...\n");
    }

    private ToolWindowManager toolWindowManager() {
        return ToolWindowManager.getInstance(project);
    }
}