<%-- 
    Document   : process
    Created on : Apr 15, 2015, 1:50:57 PM
    Author     : Samuel
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
            String password = request.getParameter("password");
            String minQ = request.getParameter("min-number");
            String[] answers = request.getParameterValues("answer");

            DataReader qr = new DataReader("D:/Skripsi/MavenShamirSS/questions.txt");
            qr.read();
            String[] questions = qr.get();
            
            int salt = (int)(Math.random()*50) + 10;

            String[] hashValue = new String[answers.length];
            Sha512 sha = new Sha512();
            for(int i = 0; i < hashValue.length; i++) {
                String message = questions[i] + "" + answers[i] + "" + salt;
                sha.setMessage(message);
                sha.createDigest();
                hashValue[i] = sha.getDigest();
                sha.reset();
            }

            int share = answers.length;
            int k = Integer.parseInt(minQ);
            int secret = (int)(Math.random()*100)+10;

            SecretSharing ss = new SecretSharing(secret);
            ss.split(share, k);

            int[] function = ss.getFunction();
            int[] shares = ss.getFx();

            Encryption e = new Encryption();
            String[] encrypted = new String[hashValue.length];
            for(int i = 1; i < shares.length; i++) {
                e.setMessage(shares[i]+"");
                e.setKey(hashValue[i-1]);
                e.initialize();
                e.encrypt();
                encrypted[i-1] = e.getCipherText();
                e.reset();
            }

            //save questions
            String writeToFile = "";
            for(int i = 0; i < answers.length; i++) {
                writeToFile += questions[i] + "\r\n";
            }
            DataWriter dw = new DataWriter("D:/Skripsi/MavenShamirSS/data_questions.txt");
            dw.write(writeToFile);

            //save answers
            writeToFile = "";
            for(int i = 0; i < encrypted.length; i++) {
                writeToFile += encrypted[i] + "\r\n";
            }
            dw = new DataWriter("D:/Skripsi/MavenShamirSS/data_answers.txt");
            dw.write(writeToFile);

            //save salt
            writeToFile = salt+"";
            dw = new DataWriter("D:/Skripsi/MavenShamirSS/data_salt.txt");
            dw.write(writeToFile);

            response.sendRedirect("index.jsp");
        %>
    </body>
</html>
