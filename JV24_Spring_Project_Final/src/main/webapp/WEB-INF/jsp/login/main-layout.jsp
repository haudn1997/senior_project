

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login V1</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="${pageContext.request.getContextPath()}/resources/css/bootstrap.css" rel='stylesheet' type='text/css' />
        <link href="${pageContext.request.getContextPath()}/resources/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="${pageContext.request.getContextPath()}/resources/css/sliderandmenu.css" rel="stylesheet" type="text/css" media="all" />
        <script src="${pageContext.request.getContextPath()}/resources/js/jquery.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Cinema Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.getContextPath()}/resources/login/vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.getContextPath()}/resources/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.getContextPath()}/resources/login/vendor/animate/animate.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.getContextPath()}/resources/login/vendor/css-hamburgers/hamburgers.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.getContextPath()}/resources/login/vendor/select2/select2.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.getContextPath()}/resources/login/css/util.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.getContextPath()}/resources/login/css/main.css">
        <script src="${pageContext.request.getContextPath()}/resources/login/vendor/jquery/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.getContextPath()}/resources/login/vendor/bootstrap/js/popper.js"></script>
        <script src="${pageContext.request.getContextPath()}/resources/login/vendor/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.getContextPath()}/resources/login/vendor/select2/select2.min.js"></script>
        <script src="${pageContext.request.getContextPath()}/resources/login/vendor/tilt/tilt.jquery.min.js"></script>
        <script src="${pageContext.request.getContextPath()}/resources/login/js/main.js"></script>
    </head>
    <body>
        <tiles:insertAttribute name="header" />
        <tiles:insertAttribute name="login" />
        <tiles:insertAttribute name="footer" />
    </body>
</html>
