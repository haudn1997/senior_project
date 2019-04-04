
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
﻿<%@ page import="java.util.*" %>
<%
    Random rn = new Random();
    String merRef = "TEST_" + System.currentTimeMillis() + rn.nextInt();
    String ipClient = request.getRemoteAddr();
%>

<div class="full">
    <div class="main">
        <div class="container">
            <div id="form-register">
                <div class="row">
                    <div class="col-xs-12 col-sm-12" style="text-align: center;">
                        <c:if test="${message!=null && message!=''}">
                            <div class="alert alert-danger" style="color: red;">
                                ${message}
                            </div>
                        </c:if>
                    </div>
                </div>

                <form action="${pageContext.request.getContextPath()}/one-pay" method="post"><input type="hidden"
                                                                                                    name="Title" value="JSP VPC 3-Party">
                    <div class="row">
                        <input type="hidden" placeholder="Id" name="userId" value="${pageContext.request.userPrincipal.principal.id}"/>
                        <input type="hidden" placeholder="Email Adress" name="email" value="${pageContext.request.userPrincipal.principal.email}"/>
                        <input type="hidden" name="virtualPaymentClientURL" size="63" value="https://mtf.onepay.vn/onecomm-pay/vpc.op" maxlength="250"/>
                        <tr>
                            <td><strong><em>Merchant ID</em></strong></td>
                            <td><input type="text" name="vpc_Merchant" value="ONEPAY" size="30"
                                       maxlength="16"/></td>
                        </tr>                         
                        <tr>
                            <td><strong><em>Merchant AccessCode</em></strong></td>
                            <td><input type="text" name="vpc_AccessCode" value="D67342C2"
                                       size="30" maxlength="8"/></td>
                        </tr>
                        <tr>
                        <input type="hidden" name="vpc_MerchTxnRef" value="<% out.println(merRef);%>" size="30" maxlength="40"/>
                        </tr>
                        <tr>
                        <input type="hidden" name="vpc_OrderInfo" value="Ma Don Hang" size="30" maxlength="34"/>
                        </tr>
                        <tr>
                            <td><strong><em>Purchase Amount</em></strong></td>
                            <td><input type="text" name="vpc_Amount" value="${total}" size="30"
                                       maxlength="10"/></td>
                        </tr>
                        <tr>
                            <td><input type="hidden" name="vpc_ReturnURL" size="50" value="http://localhost:8084/JV24_Spring_Project_Final/payment-success" maxlength="250"/></td>
                        </tr>
                        <tr>
                            <td><input type="hidden" name="vpc_Version" value="2" size="30"
                                       maxlength="8"/></td>
                        </tr>
                        <tr>
                            <td><input type="hidden" name="vpc_Command" value="pay" size="30"
                                       maxlength="16"/></td>
                        </tr>
                        <tr>
                            <td><input type="hidden" name="vpc_Locale" value="vn" size="30"
                                       maxlength="5"/></td>
                        </tr>
                        <tr>
                            <td><strong><em>Currency code</em></strong></td>
                            <td><input type="text" name="vpc_Currency" value="VND" size="30"
                                       maxlength="5"/></td>
                        </tr>
                    </div>
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
                            <input type="submit" value="THANH TOÁN"/>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>