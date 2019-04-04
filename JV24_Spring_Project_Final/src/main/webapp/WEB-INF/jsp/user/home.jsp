
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.getContextPath()}/webjars/bootstrap/3.3.7/css/bootstrap.min.css"/>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12" style="text-align: center;">
                    <h1>Demo Security</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12" style="text-align: center;">
                    <h3>${message}</h3>
                    <h3>${email}</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12" style="text-align: center;">
                    <a href="<c:url value="/home"/>">Home</a>
                    <a href="<c:url value="/logout"/>">Logout</a>
                </div>
            </div>
        </div>
    </body>
</html>
