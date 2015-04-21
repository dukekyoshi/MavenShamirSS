<%-- 
    Document   : password
    Created on : Apr 17, 2015, 11:04:42 AM
    Author     : Samuel
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="DES.Decryption"%>
<%@page import="ShamirSecretSharing.EquationSolver"%>
<%@page import="SHA512.Sha512"%>
<%@page import="ReaderWriter.DataReader"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Secret Sharing</title>
        <link href="bootstrap.min.css" rel="stylesheet">
        <link href="normalize.css" rel="stylesheet">
        <link href="font-awesome.css" rel="stylesheet">
        <link href="style.css" rel="stylesheet">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body>
        <div class="container">
            <div class="login-box col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2">
                <div class="panel panel-info" style="margin-top:20px;">
                    <div class="panel-heading">
                        <div class="panel-title">Retrieve Password</div>
                    </div>
                    <div class="panel-body">
                        <%
                            String[] answers = request.getParameterValues("answer");

                            //DataReader dr = new DataReader("D:/Skripsi/MavenShamirSS/data_questions.txt");
                            DataReader dr = new DataReader("H:/Kuliah/Skripsi/MavenShamirSS/data_questions.txt");
                            dr.read();
                            String[] questions = dr.get();

                            //dr = new DataReader("D:/Skripsi/MavenShamirSS/data_others.txt");
                            dr = new DataReader("H:/Kuliah/Skripsi/MavenShamirSS/data_others.txt");
                            dr.read();
                            int salt = Integer.parseInt(dr.get()[0]);
                            int k = Integer.parseInt(dr.get()[1]);

                            String[] hashValue = new String[answers.length];
                            Sha512 sha = new Sha512();
                            for(int i = 0; i < answers.length; i++) {
                                String msg = questions[i] + answers[i] + salt;
                                sha.setMessage(msg);
                                sha.createDigest();
                                hashValue[i] = sha.getDigest();
                                sha.reset();
                            }

                            //dr = new DataReader("D:/Skripsi/MavenShamirSS/data_answers.txt");
                            dr = new DataReader("H:/Kuliah/Skripsi/MavenShamirSS/data_answers.txt");
                            dr.read();
                            String[] encryptedAnswers = dr.get();
                            
                            int[] decryptedAnswers = new int[encryptedAnswers.length];
                            int share = answers.length;

                            Decryption d = new Decryption();
                            int count = 0;
                            for(int i = 0; i < encryptedAnswers.length; i++) {
                                d.setCipher(encryptedAnswers[i]);
                                d.setKey(hashValue[count]);
                                try {
                                    decryptedAnswers[i] = Integer.parseInt(d.binToStr(d.decrypt()).trim());
                                } catch(NumberFormatException nfe) {
                                    decryptedAnswers[i] = -1;
                                }
                                d.reset();
                                if(count == hashValue.length-1) {
                                    count = 0;
                                } else {
                                    count++;
                                }
                            }

                            ArrayList<double[]> passwordPart = new ArrayList<double[]>();
                            for(int i = 0; i < decryptedAnswers.length; ) {
                                double[] temp = new double[share];
                                for(int j = 0; j < share; j++) {
                                    temp[j] = decryptedAnswers[i];
                                    i++;
                                }
                                passwordPart.add(temp);
                            }

                            ArrayList<double[]> functions = new ArrayList<double[]>();
                            for(int a = 1; a <= share; a++) {
                                double[] f = new double[k];
                                for(int x = 0; x < f.length; x++) {
                                    f[x] = Math.pow(a, x);
                                }
                                functions.add(f);
                            }

                            double[][] equation = new double[k][k];
                            int idx = 0;
                            double[] tempPasswordPart = passwordPart.get(0);
                            for(int i = 0; i < tempPasswordPart.length; i++) {
                                if(tempPasswordPart[i] != -1 && idx < equation.length) {
                                    equation[idx] = functions.get(i);
                                    idx++;
                                }
                            }

                            EquationSolver eq = null;
                            int[] secretParts = new int[passwordPart.size()];
                            for(int i = 0; i < passwordPart.size(); i++) {
                                double[] temp = passwordPart.get(i);
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

                                eq = new EquationSolver(tempEq, solution);
                                secretParts[i] = (int)eq.solve()[0];
                            }

                            String forgottenPassword = "";
                            for(int i = 0; i < secretParts.length; i++) {
                                char ch = (char)secretParts[i];
                                forgottenPassword += ch + "";
                            }
                        %>
                        <div class="form-group">
                            <label class="col-sm-4" style="margin-top:7px;">Your password is</label>
                            <div class="col-sm-6"><input class="form-control" type="text" value="<%= forgottenPassword %>" disabled/></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4">
                                <a href="index.jsp" class="btn btn-primary">Done</a>
                                <a href="retrieve.jsp" class="btn btn-danger">Return</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
