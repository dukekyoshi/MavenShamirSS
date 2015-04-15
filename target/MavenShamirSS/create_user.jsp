<%-- 
    Document   : create_user
    Created on : Apr 15, 2015, 11:36:27 AM
    Author     : Samuel
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<%@page import="ReaderWriter.DataReader"%>
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
        <%
            String questions = request.getParameter("num-of-questions");
            String minQ = request.getParameter("min-number");
        %>
        <div class="container">
            <div class="login-box col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2">
                <div class="panel panel-info" style="margin-top:20px;">
                    <div class="panel-heading">
                        <div class="panel-title">Create User</div>
                    </div>
                    <form method="POST" action="process.jsp">
                        <input type="hidden" name="min-number" value="<%= minQ %>"/>
                        <div class="panel-body">
                            <div class="form-group">
                                <label for="pswd" style="margin-top:7px;" class="col-sm-2 control-label">Password</label>
                                <div class="col-sm-10"><input id="pswd" name="password" type="password" class="form-control"/></div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <label style="margin-top:7px;" class="col-sm-7 control-label">Security Questions</label>
                            </div>
                            <%
                                if(questions != null) {
                                    DataReader qr = new DataReader("D:/Skripsi/MavenShamirSS/questions.txt");
                                    qr.read();
                                    String[] res = qr.get();
                                    int count = Integer.parseInt(questions);
                                    if(res.length < count) {
                                        count = res.length;
                                    }
                                    for(int i = 0; i < count; i++) {
                            %>
                                        <div class="form-group">
                                            <label for="num" style="margin-top:7px;" class="col-sm-1 control-label"><%= (i+1) + "." %></label>
                                            <label for="questions" style="margin-top:7px;" class="col-sm-7 control-label"><%= res[i] %></label>
                                            <div class="col-sm-4"><input id="quest" name="answer" type="text" class="form-control"/></div>
                                        </div>
                            <%
                                    }
                                }
                            %>
                            <hr/>
                            <div class="form-group">
                                <input type="submit" class="btn btn-info" value="Create User"/>
                                <a class="btn btn-danger" href="choose.jsp">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
