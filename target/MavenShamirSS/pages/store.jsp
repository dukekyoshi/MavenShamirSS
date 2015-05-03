<%-- 
    Document   : store
    Created on : May 1, 2015, 8:08:05 PM
    Author     : Sam
--%>

<%@page import="ReaderWriter.DataReader" %>
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
                        <div class="panel-title">Store Password</div>
                    </div>
                    <form method="POST" action="process.jsp" onsubmit="return count()">
                        <div class="panel-body">
                            <input type="button" style="margin-left: 12px;" class="btn btn-primary" id="addPassword" value="Add Password"/>
                            <hr class="pswd-hr"/>
                            <div class="form-group">
                                <label style="margin-top:7px;" class="col-sm-7 control-label">Security Questions</label>
                            </div>
                            <div style="display:none;" id="counter">1</div>
                            <div class="form-group">
                                <div class="col-sm-9"><input type="text" id="question" class="form-control" placeholder="Question Here"/></div>
                                <div class="col-sm-2"><input type="button" id="add" class="btn btn-primary" value="Add"/></div>
                            </div>
                            <hr class="submit-buttons-hr"/>
                            <div class="form-group">
                                <input type="submit" class="btn btn-info" value="Store"/>
                                <a class="btn btn-danger" href="../index.jsp">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="../js/jquery-2.1.1.js" type="text/javascript"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../js/app.js" type="text/javascript"></script>
    </body>
</html>
