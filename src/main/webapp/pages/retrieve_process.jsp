<%-- 
    Document   : retrieve_process
    Created on : May 1, 2015, 9:50:08 PM
    Author     : Sam
--%>

<%@page import="ShamirSecretSharing.SecretSharing"%>
<%@page import="ShamirSecretSharing.EquationSolver"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Arrays"%>
<%@page import="DES.DESDecryption"%>
<%@page import="SHA512.Sha512"%>
<%@page import="ReaderWriter.DataReader"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Secret Sharing</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/normalize.css" rel="stylesheet">
        <link href="../css/font-awesome.css" rel="stylesheet">
        <link href="../css/style.css" rel="stylesheet">
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
                            String path = getServletContext().getRealPath("data");
                            File folder = new File(path);
                            File[] listPassword = folder.listFiles(new FilenameFilter() {
                                @Override
                                public boolean accept(File dir, String name) {
                                    return (name.contains("data_answers") && name.endsWith(".txt")) && (!name.contains("case"));
                                }
                            });
                            
                            String[] answers = request.getParameterValues("answer");
                            String[] questions = request.getParameterValues("questions");
                            int n = answers.length;

                            DataReader dr = new DataReader(path + "\\data_others.txt");
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

                            int[] decryptedAnswers = new int[1];
                            ArrayList<double[]> passwordPart = new ArrayList<double[]>();
                            SecretSharing ss = new SecretSharing();
                            String[] passwords = new String[listPassword.length];
                            for(int passCount = 0; passCount < listPassword.length; passCount++) {
                                passwordPart = new ArrayList<double[]>();
                                dr = new DataReader(listPassword[passCount].getAbsolutePath());
                                dr.read();
                                String[] encryptedAnswers = dr.get();
                                decryptedAnswers = new int[encryptedAnswers.length];

                                DESDecryption d = new DESDecryption();
                                int count = 0;
                                for(int j = 0; j < encryptedAnswers.length; j++) {
                                    d.setCipher(encryptedAnswers[j]);
                                    d.setKey(hashValue[count]);
                                    try {
                                        decryptedAnswers[j] = Integer.parseInt(d.binToStr(d.decrypt()).trim());
                                    } catch(NumberFormatException nfe) {
                                        decryptedAnswers[j] = -1;
                                    }
                                    d.reset();
                                    if(count == hashValue.length-1) {
                                        count = 0;
                                    } else {
                                        count++;
                                    }
                                }

                                for(int j = 0; j < decryptedAnswers.length; ) {
                                    double[] temp = new double[n];
                                    for(int idx = 0; idx < n; idx++) {
                                        temp[idx] = decryptedAnswers[j];
                                        j++;
                                    }
                                    passwordPart.add(temp);
                                }
                                
                                passwords[passCount] = ss.reconstruct(n, k, passwordPart);
                            }
                        %>
                        <%
                            for(int i = 0; i < passwords.length; i++) {
                        %>
                            <% if(passwords[i] == "") { %>
                                <div class="form-group">
                                    <div class="failed-notification">Password cannot be retrieved</div>
                                </div>
                                <% i = passwords.length; %>
                            <% } else { %>
                                <div class="form-group">
                                    <label class="col-sm-4" style="margin-top:7px;">Your password is</label>
                                    <div class="col-sm-6"><input class="form-control" type="text" value="<%= passwords[i] %>" disabled/></div>
                                </div>
                            <% } %>
                        <% } %>
                        <div class="form-group">
                            <div class="col-sm-4">
                                <a href="../index.jsp" class="btn btn-primary">Done</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
