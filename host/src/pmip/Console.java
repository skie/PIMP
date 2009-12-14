package pmip;

import java.awt.*;

public interface Console {
    void init();
    void print(Object message);
    void println(Object message);
    void error(Object message);
    void dispose();
    Component getComponent();
}
