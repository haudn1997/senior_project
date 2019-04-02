



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link type="text/css" rel="stylesheet" href="${pageContext.request.getContextPath()}/webjars/bootstrap/3.3.7/css/bootstrap.min.css"/>

<div class="main-panel">
    <nav class="navbar navbar-default navbar-fixed">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Dashboard</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <div style="margin-top: 10px;padding-left: 100px">
                            <div class="group-login-register">
                                <sec:authorize access="isAuthenticated()">
                                    <div class="group-login-register">
                                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                                            <span class="email"><sec:authentication property='principal.fullName'/></span>
                                        </sec:authorize> 
                                        <span class="gach-doc"></span>
                                        <a href="<c:url value="/logout"/>">&nbsp;&nbsp;Logout</a>
                                    </div>           
                                </sec:authorize>
                            </div>

                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


    <div class="content">
        <div class="container-fluid">
            <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center">
                <h1>Register Form </h1>
            </div>
            <c:if test="${message != null && message != ''}">
                <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center">
                    <div class="alert alert-danger">${message}</div>
                </div>
            </c:if>
            <div class="col-xs-12 col-sm-12 col-md-12">
                <f:form action="${pageContext.request.getContextPath()}/admin/${action}" method="post" modelAttribute="user" class="form-horizontal">
                    <c:if test="${action== 'update-user'}">
                        <input type="text" hidden name="id" value="${user.id}"/>
                    </c:if>


                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Full Name:</label>
                        <div class="col-xs-8 col-sm-8">
                            <input name="fullName" type="text" placeholder="" class="form-control" value="${user.fullName}" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Email:<span style="color: red">(*)</span></label>
                        <div class="col-xs-8 col-sm-8">
                            <input name="email"  type="email"  class="form-control" required value="${user.email}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Password:<span style="color: red">(*)</span></label>
                        <div class="col-xs-8 col-sm-8">
                            <input name="password"  type="password"  class="form-control" required value="${user.password}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Address:<span style="color: red">(*)</span></label>
                        <div class="col-xs-8 col-sm-8">
                            <input name="address"  type="text" class="form-control" required value="${user.address}" />                                                         
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">PhoneNumber: <span style="color: red">(*)</span></label>
                        <div class="col-xs-8 col-sm-8">
                            <input name="phoneNumber"  type="text" class="form-control" required="" value="${user.phoneNumber}"/>                                                         
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Gender: <span style="color: red">(*)</span></label>
                        <div class="col-xs-8 col-sm-8">
                            <c:forEach items="${genders}" var="gender">
                                <c:if test="${user.gender== gender}">
                                    <label class="radio-inline">
                                        <input name="gender" checked  type="radio" required="" value="${gender}"/> 
                                        ${gender}  
                                    </label>
                                </c:if>
                                <c:if test="${user.gender!= gender}">
                                    <label class="radio-inline">
                                        <input name="gender"  type="radio"  required="" value="${gender}"/> 
                                        ${gender}  
                                    </label>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="form-group" style="text-align: center">
                        <input type="submit" class="btn btn-danger" value="Register"/>
                    </div>
                </f:form>
            </div>
        </div>
    </div>

</div>
