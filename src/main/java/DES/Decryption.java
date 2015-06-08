package DES;

public class Decryption extends DataEncryptionStandard {

    public Decryption() {
    }

    public void setCipher(String c) {
        String bin = "";
        for(int i = 0; i < c.length(); i++) {
            int hex = Integer.parseInt(c.charAt(i)+"", 16);
            String temp = String.format("%4s", Integer.toBinaryString(hex)).replace(' ', '0');
            bin += temp;
        }
        cipher = bin;
    }

    public void setKey(String k) {
        for(int i = 0; i < k.length(); i++) {
            key += String.format("%8s", Integer.toBinaryString(k.charAt(i))).replace(' ', '0');
        }
    }

    public String decrypt() {
        createSubKey();
        String plainText = "";

        String[] cipherBlock = cipher.split("(?<=\\G.{64})");

        for(int block = 0; block < cipherBlock.length; block++) {
            String init = initialPermutation(cipherBlock[block]);
            String L0 = init.substring(0,init.length()/2);
            String R0 = init.substring(init.length()/2, init.length());

            //16 rounds inverse
            String[] arr = {L0, R0};
            for(int i = 15; i >= 0; i--) {
                arr = round(arr[0], arr[1], roundKey[i]);
            }

            String tempPlainText = arr[1] + arr[0];
            tempPlainText = permute(tempPlainText, IP1);
            plainText += tempPlainText;
        }

        return plainText;
    }
    
    public String binToStr(String bin) {
        String text = "";
        String[] temp = bin.split("(?<=\\G.{8})");
        for(int i = 0; i < temp.length; i++) {
            text += (char)Integer.parseInt(temp[i], 2);
        }
        return text;
    }
}
