package ShamirSecretSharing;

public class SecretSharing {

    /**
     * ATTRIBUTES
     */
    private int[] function;
    private int[] fx;
    private int secret;

    /**
     * CONSTRUCTOR
     */
    public SecretSharing(int s) {
        secret = s;
    }

    /**
     * ACCESSOR
     */
    public int[] getFunction() {
        return function;
    }
    public int[] getFx() {
        return fx;
    }

    /**
     * OTHERS
     */
    public void split(int share, int k) {
        function = new int[k];
        function[0] = secret;
        for(int i = 1; i < function.length; i++) {
            function[i] = (int)(Math.random()*50) + 1;
        }

        Function fcount = new Function(function);
        //f(0) is secret
        fx = new int[share+1];
        for(int i = 0; i <= share; i++) {
            fx[i] = fcount.countFunction(i);
        }
    }
}
