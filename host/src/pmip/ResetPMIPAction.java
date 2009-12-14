package pmip;

import com.intellij.openapi.util.IconLoader;

import javax.swing.*;
import java.awt.event.ActionEvent;

class ResetPMIPAction extends AbstractAction {

    private final PMIP pmip;

    public ResetPMIPAction(PMIP pmip) {
        super("Reset", IconLoader.getIcon("/actions/sync.png"));
        this.pmip = pmip;
        putValue(SHORT_DESCRIPTION, "Reset");
    }

    public void actionPerformed(ActionEvent aActionEvent) {
        pmip.resetInterpreter();
    }
}
