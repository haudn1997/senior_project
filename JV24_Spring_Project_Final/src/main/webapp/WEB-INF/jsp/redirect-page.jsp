
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:authorize access="!isAuthenticated()">
    <c:redirect url="/home" />
</sec:authorize>
<sec:authorize access="isAuthenticated()">
    <sec:authorize access="hasAnyRole('ROLE_USER')">
        <c:redirect url="/user/home" />
    </sec:authorize>
    <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
        <c:redirect url="/admin/home" />
    </sec:authorize>
        
</sec:authorize>
