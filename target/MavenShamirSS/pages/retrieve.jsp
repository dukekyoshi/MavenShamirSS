<%--
    Document   : retrieve
    Created on : May 1, 2015, 8:08:05 PM
    Author     : Sam
--%>

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
            <div class="login-box col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1">
                <div class="panel panel-info" style="margin-top:20px;">
                    <div class="panel-heading">
                        <div class="panel-title">Retrieve Password</div>
                    </div>
                    <form action="retrieve_process.jsp" method="POST">
                        <div class="panel-body">
                            <div class="form-group">
                                <label style="margin-top:7px;" class="col-sm-7 control-label">Security Questions</label>
                            </div>
                            <%
                                String path = getServletContext().getRealPath("data");
                                DataReader dr = new DataReader(path + "\\data_questions.txt");
                                dr.read();
                                String[] questions = dr.get();
                                for(int i = 0; i < questions.length; i++) {
                            %>
                                    <div class="form-group">
                                        <label for="num" style="margin-top:7px;" class="col-sm-1 control-label"><%= (i+1) + "." %></label>
                                        <label for="answer" style="margin-top:7px;" class="col-sm-7 control-label"><%= questions[i] %></label>
                                        <div class="col-sm-4"><input id="ans" name="answer" type="text" class="form-control"/></div>
                                        <input type="hidden" name="questions" value="<%= questions[i] %>"/>
                                    </div>
                            <%
                                }
                            %>
                            <hr/>
                            <div class="form-group">
                                <input type="submit" class="btn btn-info" value="Submit"/>
                                <a class="btn btn-danger" href="../index.jsp">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
