package ShamirSecretSharing;

public class EquationSolver {

    /**
     * ATTRIBUTES
     */
     double[][] equationMatrix;
     double[] solutionMatrix;

    public EquationSolver(double[][] equation, double[] solution) {
        equationMatrix = equation;
        solutionMatrix = solution;
    }

    public void reset() {
        equationMatrix = new double[1][1];
        solutionMatrix = new double[1];
    }

    public double[] solve() {
        int n = solutionMatrix.length;
        for(int k = 0; k < n; k++) {
            /*set pivot row*/
            int max = k;
            for(int row = k+1; row < n; row++) {
                if(Math.abs(equationMatrix[row][k]) > Math.abs(equationMatrix[max][k])) {
                    max = row;
                }
            }

            /*swap with pivot row  matrix A*/
            double[] temp = equationMatrix[max];
            equationMatrix[max] = equationMatrix[k];
            equationMatrix[k] = temp;

            /*swap solution matrix B*/
            double tmp = solutionMatrix[max];
            solutionMatrix[max] = solutionMatrix[k];
            solutionMatrix[k] = tmp;

            /*set matrix into triangle matrix*/
            for (int row = k+1; row < n; row++) {
                double factor = equationMatrix[row][k] / equationMatrix[k][k];
                solutionMatrix[row] -= factor * solutionMatrix[k];
                for (int col = k; col < n; col++) {
                    equationMatrix[row][col] -= factor * equationMatrix[k][col];
                }
            }
        }

        /*substitution to find solution*/
        double[] solution = new double[n];

        for (int row = n - 1; row >= 0; row--) {
            double sum = 0.0;
            for (int j = row + 1; j < n; j++) {
                sum += equationMatrix[row][j] * solution[j];
            }
            solution[row] = (solutionMatrix[row] - sum) / equationMatrix[row][row];
        }
        return solution;
    }

    //f(x) = res
    public double countFunction(double[] function, int x) {
        double res = 0;
        for(int i = 0; i < function.length; i++) {
            res += function[i] * Math.pow(x,i);
        }
        return res;
    }
}
