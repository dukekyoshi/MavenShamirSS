<%-- 
    Document   : choose
    Created on : Apr 15, 2015, 11:32:40 AM
    Author     : Samuel
--%>

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
                        <div class="panel-title">Choose N and K</div>
                    </div>
                    <form action="create_user.jsp" method="GET">
                        <div class="panel-body">
                            <div class="form-group">
                                <label for="number" style="margin-top:7px;" class="col-sm-6 control-label">Number of Questions</label>
                                <label style="margin-top:7px;" class="col-sm-1">:</label>
                                <div class="col-sm-5"><input id="number" name="num-of-questions" type="text" class="form-control"/></div>
                            </div>
                            <div class="form-group">
                                <label for="min-number" style="margin-top:7px;" class="col-sm-6 control-label">Minimum Number of Correct Answers</label>
                                <label style="margin-top:7px;" class="col-sm-1">:</label>
                                <div class="col-sm-5"><input id="min-number" name="min-number" type="text" class="form-control"/></div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <input type="submit" class="btn btn-info" value="Submit"/>
                                <a class="btn btn-danger" href="index.jsp">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
