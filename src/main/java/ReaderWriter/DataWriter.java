package ReaderWriter;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;

public class DataWriter {

    /**
     * ATTRIBUTES
     */
    private String filename;
    private String content;

    public DataWriter() {
    }
    
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

    //how many data contains answers must be deleted to write a new one
    //"\\data_answers_" + count + ".txt"
    public void deleteFiles(String path) {
        try {
            File folder = new File(path);
            File[] list = folder.listFiles(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return (name.contains("data_answers") && !name.contains("case"));
                }
            });
            for(int i = 0; i < list.length; i++) {
                list[i].delete();
            }
        } catch (Exception e) {
        }
    }
}
