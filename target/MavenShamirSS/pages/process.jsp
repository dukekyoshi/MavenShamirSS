<%-- 
    Document   : process
    Created on : May 1, 2015, 8:42:30 PM
    Author     : Sam
--%>

<%@page import="java.util.Arrays"%>
<%@page import="ReaderWriter.DataWriter"%>
<%@page import="ReaderWriter.DataReader"%>
<%@page import="SHA512.Sha512"%>
<%@page import="DES.Encryption"%>
<%@page import="ShamirSecretSharing.SecretSharing"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Secret Sharing</title>
    </head>
    <body>
        <%
            String[] passwords = request.getParameterValues("password");
            String[] questions = request.getParameterValues("questions");
            String[] answers = request.getParameterValues("answer");
            String path = getServletContext().getRealPath("data");

            int n = questions.length;
            int k = passwords.length;
            if(k <= 3) {
                k = 4;
            }

            int salt = (int)(Math.random()*50) + 10;

            String[] hashValue = new String[answers.length];
            Sha512 sha = new Sha512();
            for(int i = 0; i < hashValue.length; i++) {
                String message = questions[i] + answers[i] + salt;
                sha.setMessage(message);
                sha.createDigest();
                hashValue[i] = sha.getDigest();
                sha.reset();
            }

            DataWriter dw = null;
            String writeToFile = "";
            Encryption e = new Encryption();
            for(int count = 0; count < passwords.length; count++) {
                String password = passwords[count];
                String[] encrypted = new String[password.length()*n];
                
                int secret = 0;
                int encIdx = 0;
                for(int i = 0; i < password.length(); i++) {
                    secret = (int)(password.charAt(i));
                    SecretSharing ss = new SecretSharing(secret);
                    ss.split(n, k);

                    int[] function = ss.getFunction();
                    int[] shares = ss.getFx();

                    for(int j = 1; j < shares.length; j++) {
                        e.setMessage(shares[j]+"");
                        e.setKey(hashValue[j-1]);
                        e.initialize();
                        e.encrypt();
                        encrypted[encIdx] = e.getCipherText();
                        encIdx++;
                        e.reset();
                    }
                }

                //save answers
                writeToFile = "";
                for(int i = 0; i < encrypted.length; i++) {
                    writeToFile += encrypted[i] + "\r\n";
                }
                dw = new DataWriter(path + "\\data_answers_" + count + ".txt");
                dw.write(writeToFile);
            }

            //save questions
            writeToFile = "";
            for(int i = 0; i < questions.length; i++) {
                writeToFile += questions[i] + "\r\n";
            }
            dw = new DataWriter(path + "\\data_questions.txt");
            dw.write(writeToFile);

            //save salt and min question
            writeToFile = salt + "\r\n" + k;
            dw = new DataWriter(path + "\\data_others.txt");
            dw.write(writeToFile);

            response.sendRedirect("../index.jsp");
        %>
    </body>
</html>
