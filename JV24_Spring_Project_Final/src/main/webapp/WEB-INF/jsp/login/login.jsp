

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="full">     
    <div class="main"> 
        <div class="limiter">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12 col-sm-12" style="text-align: center;">
                        <c:if test="${message!=null && message!=''}">
                            <div class="alert alert-danger">
                                ${message}
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="container-login100">
                    <div class="wrap-login100">
                        <div class="login100-pic js-tilt" data-tilt>
                            <img src="<c:url value="resources/login/images/img-01.png"/>" alt="IMG">
                        </div>

                        <form action="<c:url value="j_spring_security_check"/>" method="post" class="login100-form validate-form">
                            <span class="login100-form-title">
                                Member Login
                            </span>

                            <div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                                <input class="input100" type="text" name="email" placeholder="Email">
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
                                    <i class="fa fa-envelope" aria-hidden="true"></i>
                                </span>
                            </div>

                            <div class="wrap-input100 validate-input" data-validate = "Password is required">
                                <input class="input100" type="password" name="password" placeholder="Password">
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
                                    <i class="fa fa-lock" aria-hidden="true"></i>
                                </span>
                            </div>

                            <div class="container-login100-form-btn">
                                <button type="submit" class="login100-form-btn">
                                    Login
                                </button>
                            </div>
                            <div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>