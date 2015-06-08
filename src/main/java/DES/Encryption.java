package DES;

public class Encryption extends DataEncryptionStandard {

    /**
     * ATTRIBUTES
     */
    String strMsg;
    String strKey;
    String msg;
    String[] msgBlock;

    public Encryption() {
        strMsg = "";
        strKey = "";
        msg = "";
        msgBlock = new String[1];
    }

    @Override
    public void reset() {
        strMsg = "";
        strKey = "";
        msg = "";
        key = "";
        roundKey = new String[16];
        cipher = "";
        msgBlock = new String[1];
    }

    public void encrypt() {
        createSubKey();
        String tempCipher = "";
        for(int block = 0; block < msgBlock.length; block++) {
            String init = initialPermutation(msgBlock[block]);
            String L0 = init.substring(0,init.length()/2);
            String R0 = init.substring(init.length()/2, init.length());

            //16 rounds
            String[] arr = {L0, R0};
            for(int i = 0; i < 16; i++) {
                arr = round(arr[0], arr[1], roundKey[i]);
            }

            tempCipher = arr[1] + arr[0];
            tempCipher = permute(tempCipher, IP1);
            cipher += tempCipher;
        }
    }

    public String getCipherText() {
        String cipherText = "";
        String[] temp = cipher.split("(?<=\\G.{4})");
        for(int i = 0; i < temp.length; i++) {
            cipherText += Integer.toHexString(Integer.parseInt(temp[i], 2));
        }
        return cipherText;
    }

    public void initialize() {
        String tempMessage = "";
        for(int i = 0; i < strMsg.length(); i++) {
            tempMessage += String.format("%8s", Integer.toBinaryString(strMsg.charAt(i))).replace(' ', '0');
        }

        int padLength = (64 - (tempMessage.length() % 64)) / 8;
        String padding = "";
        for(int i = 0; i < padLength; i++) {
            padding += String.format("%8s", Integer.toBinaryString(32)).replace(' ', '0');
        }

        msg = tempMessage + padding;

        msgBlock = msg.split("(?<=\\G.{64})");

        for(int i = 0; i < strKey.length(); i++) {
            key += String.format("%8s", Integer.toBinaryString(strKey.charAt(i))).replace(' ', '0');
        }
    }
    public void setMessage(String m) {
        strMsg = m;
    }

    public void setKey(String k) {
        strKey = k;
    }
}
