<%-- 
    Document   : check-info
    Created on : Oct 31, 2018, 10:06:57 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="full">
    <div class="main">
        <div class="container" id="form-register">
            <div class="row">
                <div class="col-xs-12 col-sm-12" style="text-align: center;">
                    <c:if test="${message!=null && message!=''}">
                        <div class="alert alert-danger" style="color: red;">
                            ${message}
                        </div>
                    </c:if>
                </div>
            </div>
            <form action="${pageContext.request.getContextPath()}/check-out" method="post">
                <div class="row">
                    <h4 style="margin-bottom: 20px;">Thông tin khách hàng:</h4>
                    <div class="input-group input-group-icon">
                        <input type="text" hidden placeholder="Id" name="userId" value="${pageContext.request.userPrincipal.principal.id}"/>
                        <div class="input-icon"><i class="fa fa-user"></i></div>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="text" placeholder="Full Name" name="fullName" value="${pageContext.request.userPrincipal.principal.fullName}"/>
                        <div class="input-icon"><i class="fa fa-user"></i></div>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="email" placeholder="Email Adress" name="email" value="${pageContext.request.userPrincipal.principal.email}"/>
                        <div class="input-icon"><i class="fa fa-envelope"></i></div>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="text" placeholder="Address" name="address" value="${pageContext.request.userPrincipal.principal.address}"/>
                        <div class="input-icon"><i class="fa fa-envelope"></i></div>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="text" placeholder="Phone Number" name="phoneNumber" value="${pageContext.request.userPrincipal.principal.phoneNumber}"/>
                        <div class="input-icon"><i class="fa fa-phone"></i></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-half">
                        <h4>Giới tính</h4>
                        <c:if test="${pageContext.request.userPrincipal.principal.gender == 'Male'}">
                            <div class="input-group gender">
                                <input type="radio" name="gender" value="Male" checked id="gender-male"/>
                                <label for="gender-male">Male</label>
                                <input type="radio" name="gender" value="Female" id="gender-female"/>
                                <label for="gender-female">Female</label>
                            </div>
                        </c:if>
                        <c:if test="${pageContext.request.userPrincipal.principal.gender == 'Female'}">
                            <div class="input-group gender">
                                <input type="radio" name="gender" value="Male" id="gender-male"/>
                                <label for="gender-male">Male</label>
                                <input type="radio" name="gender" value="Female" checked id="gender-female"/>
                                <label for="gender-female">Female</label>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="row">
                    <div class="input-group input-group-icon">
                        <input type="submit" value="Xong"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>