package ReaderWriter;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class DataReader {

    /**
     * ATTRIBUTES
     */
    private String filename;
    private ArrayList<String> content;

    public DataReader(String file) {
        filename = file;
        content = new ArrayList<String>();
    }

    public String[] get() {
        String[] str = new String[content.size()];
        for(int i = 0; i < str.length; i++) {
            str[i] = content.get(i);
        }
        return str;
    }

    public void read() {
        BufferedReader br = null;
        try {
            String sCurrentLine;
            br = new BufferedReader(new FileReader(filename));
            while ((sCurrentLine = br.readLine()) != null) {
                content.add(sCurrentLine);
            }
        } catch (IOException e) {
        } finally {
            try {
                if (br != null) {
                    br.close();
                }
            } catch (IOException ex) {
            }
        }
    }
}
