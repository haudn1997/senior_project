<%-- 
    Document   : register
    Created on : Sep 25, 2018, 10:33:03 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
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
            <f:form action="${pageContext.request.getContextPath()}/register-handle" method="post" modelAttribute="user">
                <div class="row">
                    <h4>Account</h4>
                    <div class="input-group input-group-icon">
                        <input type="text" placeholder="Full Name" name="fullName" required/>
                        <div class="input-icon"><i class="fa fa-user"></i></div>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="email" placeholder="Email Adress" name="email" required/>
                        <div class="input-icon"><i class="fa fa-envelope"></i></div>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="password" placeholder="Password" name="password" required/>
                        <div class="input-icon"><i class="fa fa-key"></i></div>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="text" placeholder="Address" name="address"/>
                        <div class="input-icon"><i class="fa fa-envelope"></i></div>
                    </div>
                    <div class="input-group input-group-icon">
                        <input type="text" placeholder="Phone Number" name="phoneNumber"/>
                        <div class="input-icon"><i class="fa fa-phone"></i></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-half">
                        <h4>Gender</h4>
                        <div class="input-group gender">
                            <input type="radio" name="gender" value="Male" id="gender-male"/>
                            <label for="gender-male">Male</label>
                            <input type="radio" name="gender" value="Female" id="gender-female"/>
                            <label for="gender-female">Female</label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="input-group input-group-icon">
                        <input type="submit" value="Đăng ký"/>
                    </div>
                </div>
            </f:form>
        </div>
    </div>
</div>
