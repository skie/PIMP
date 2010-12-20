package pmip;

import java.awt.*;

public interface Console {
    void init();
    void dispose();
    Component getComponent();

    void print(Object message);
    void println(Object message);
    void error(Object message);
    void reset();
}
