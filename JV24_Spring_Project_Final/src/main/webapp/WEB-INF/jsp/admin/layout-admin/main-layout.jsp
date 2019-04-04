
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <c:import url="../include/headerAdmin.jsp" />
    </head>
    <body>
        <div class="wrapper">
        <tiles:insertAttribute name="header" />
        <tiles:insertAttribute name="body" />
        </div>
    </body>
</html>
