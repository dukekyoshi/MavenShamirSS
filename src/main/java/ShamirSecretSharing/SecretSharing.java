package ShamirSecretSharing;

import java.util.ArrayList;

public class SecretSharing {

    /**
     * ATTRIBUTES
     */
    private int[] function;
    private int[] fx;
    private int secret;
    private EquationSolver solver;

    /**
     * CONSTRUCTOR
     */
    public SecretSharing(int s) {
        secret = s;
    }
    public SecretSharing() {
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

    public String reconstruct(int n, int k, ArrayList<double[]> parts) {
        ArrayList<double[]> functions = new ArrayList<double[]>();
        for(int a = 1; a <= n; a++) {
            double[] f = new double[k];
            for(int x = 0; x < f.length; x++) {
                f[x] = Math.pow(a, x);
            }
            functions.add(f);
        }

        double[][] equation = new double[k][k];
        int idx = 0;
        double[] tempPasswordPart = parts.get(0);
        for(int i = 0; i < tempPasswordPart.length; i++) {
            if(tempPasswordPart[i] != -1 && idx < equation.length) {
                equation[idx] = functions.get(i);
                idx++;
            }
        }

        int[] finalPart = new int[parts.size()];
        for(int i = 0; i < parts.size(); i++) {
            double[] temp = parts.get(i);
            double[] solution = new double[k];
            double[][] tempEq = new double[k][k];
            for(int row = 0; row < equation.length; row++) {
                for(int col = 0; col < equation[row].length; col++) {
                    tempEq[row][col] = equation[row][col];
                }
            }

            idx = 0;
            for(int c = 0; c < temp.length; c++) {
                if(temp[c] != -1 && idx < solution.length) {
                    solution[idx] = temp[c];
                    idx++;
                }
            }
            solver = new EquationSolver(tempEq, solution);
            finalPart[i] = (int)solver.solve()[0];
        }

        String forgottenPassword = "";
        for(int i = 0; i < finalPart.length; i++) {
            if(finalPart[i] != 0) {
                char ch = (char)finalPart[i];
                forgottenPassword += ch + "";
            }
        }
        return forgottenPassword;
    }
}
