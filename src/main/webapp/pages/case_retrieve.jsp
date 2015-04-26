<%-- 
    Document   : case_retrieve
    Created on : Apr 26, 2015, 9:24:26 PM
    Author     : Sam
--%>

<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/normalize.css" rel="stylesheet">
        <link href="../css/font-awesome.css" rel="stylesheet">
        <link href="../css/style.css" rel="stylesheet">
        <title>Secret Sharing</title>
    </head>
    <body>
        <%
            String path = getServletContext().getRealPath("cases");
            File folder = new File(path);
            File[] list = folder.listFiles(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return (name.contains("case") && name.endsWith(".txt"));
                }
            });
        %>
        <div class="container">
            <div class="login-box col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3">
                <div class="panel panel-info" style="margin-top:20px;">
                    <div class="panel-heading">
                        <div class="panel-title">Cases</div>
                    </div>
                    <form action="retrieve.jsp" method="GET">
                        <div class="panel-body">
                            <div class="form-group" style="padding-left:45px !important;">
                                <select class="form-control" name="questionsPool" style="width:400px;display:inline;">
                                    <% for(int i = 0; i < list.length; i++) { %>
                                    <option value="<%= list[i].getName() %>"><%= list[i].getName() %></option>
                                    <% } %>
                                </select>
                            </div>
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
