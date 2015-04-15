package ReaderWriter;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class DataWriter {

    /**
     * ATTRIBUTES
     */
    private String filename;
    private String content;

    public DataWriter(String name) {
        filename = name;
    }

    public void write(String text) throws IOException {
        content = text;
        try {
            File file = new File(filename);
            
            file.createNewFile();

            FileWriter fw = new FileWriter(file.getAbsoluteFile(), false);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(content);
            bw.close();

            System.out.println("Done");

        } catch (IOException e) {
        }
    }
}
