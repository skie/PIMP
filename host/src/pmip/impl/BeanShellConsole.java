package pmip.impl;

import bsh.util.JConsole;
import static com.intellij.openapi.util.IconLoader.getIcon;
import pmip.Console;
import pmip.PMIP;
import sugar.Reflect;

import javax.swing.*;
import java.awt.*;
import static java.awt.Font.PLAIN;

public class BeanShellConsole implements Console {

    private JConsole console;

    public BeanShellConsole() {
        console = new JConsole();
        console.setFont(new Font("MONOSPACED", PLAIN, 11));
        console.setAutoscrolls(true);
    }

    public void init() {
        reset();
    }

    public void reset() {
        clearConsoleContentInAVileManner();
        console.print(getIcon("/logo.png"));
        console.println();
        console.println("Poor Man's IDE Plugin (PMIP) - Version: " + PMIP.getVersion());
        console.println("Copyright (c) 2009-2010 Paul Allton");
        console.println("Pimp My IDE!");
        console.println();
        console.requestFocus();
    }

    public void print(Object message) {
        console.print(message);
    }

    public void println(Object message) {
        console.println(message);
    }

    public void error(Object message) {
        console.error(message);
    }

    public void dispose() {
        console.removeAll();
        console = null;
    }

    public Component getComponent() {
        return console;
    }

    private void clearConsoleContentInAVileManner() {
        JTextPane text = (JTextPane) Reflect.getField(console, "text");
        text.selectAll();
        text.cut();
    }
}