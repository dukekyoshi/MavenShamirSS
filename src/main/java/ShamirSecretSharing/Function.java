package ShamirSecretSharing;

public class Function {

    /**
     * ATTRIBUTES
     */
    private int[] function;

    /**
     * CONSTRUCTOR
     */
    public Function(int[] func) {
        function = func;
    }

    /**
     * OTHERS
     */
    //f(x) = res
    public int countFunction(int x) {
        int res = 0;
        for(int i = 0; i < function.length; i++) {
            res += function[i] * Math.pow(x,i);
        }
        return res;
    }
}
