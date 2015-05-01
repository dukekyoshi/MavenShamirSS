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
        <link href="../../css/bootstrap.min.css" rel="stylesheet">
        <link href="../../css/normalize.css" rel="stylesheet">
        <link href="../../css/font-awesome.css" rel="stylesheet">
        <link href="../../css/style.css" rel="stylesheet">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body>
        <div class="container">
            <div class="login-box col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1">
                <div class="panel panel-info" style="margin-top:20px;">
                    <div class="panel-heading">
                        <div class="panel-title">Create User</div>
                    </div>
                    <form method="POST" action="process.jsp" onsubmit="return check()">
                        <div class="panel-body">
                            <div class="form-group">
                                <label for="pswd" style="margin-top:7px;" class="col-sm-6 control-label">Password</label>
                                <label style="margin-top:7px;" class="col-sm-1">:</label>
                                <div class="col-sm-5"><input id="pswd" name="password" type="password" class="form-control" required="required"/></div>
                            </div>
                            <div class="form-group">
                                <label for="min-number" style="margin-top:7px;" class="col-sm-6 control-label">Minimum Number of Correct Answers</label>
                                <label style="margin-top:7px;" class="col-sm-1">:</label>
                                <div class="col-sm-5"><input id="min-number" name="min-number" type="text" class="form-control k-value" required="required"/></div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <label style="margin-top:7px;" class="col-sm-7 control-label">Security Questions</label>
                            </div>
                            <%
                                String caseNum = request.getParameter("questionsPool").replace(".txt", "");
                                String[] res = new String[1];
                                String path = getServletContext().getRealPath("cases");
                                String filename = path + "\\" + request.getParameter("questionsPool");
                                DataReader qr = new DataReader(filename);
                                qr.read();
                                res = qr.get();
                            %>
                            <input type="hidden" value="<%= caseNum %>" name="case"/>
                            <div style="display:none;" id="counter">1</div>
                            <div class="form-group" style="padding-left:15px !important;">
                                <select class="form-control" id="selectQuestions" style="width:600px;display:inline;">
                                    <%
                                        for(int i = 0; i < res.length; i++) {
                                    %>
                                    <option value="<%= res[i] %>" id="<%= "option" + i%>"><%= res[i] %></option>
                                    <% } %>
                                </select>
                                <input type="button" class="btn btn-primary" id="addQuestions" value="Add"/>
                            </div>
                            <hr class="submit-buttons-hr"/>
                            <div class="form-group">
                                <input type="submit" class="btn btn-info" value="Create User"/>
                                <a class="btn btn-danger" href="choose.jsp">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="../../js/jquery-2.1.1.js" type="text/javascript"></script>
	<script src="../../js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../../js/app.js" type="text/javascript"></script>
    </body> 
</html>
