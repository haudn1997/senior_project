

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
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
                <f:form action="${pageContext.request.getContextPath()}/register-handle" method="post" modelAttribute="user">
                    <div class="row">
                        <h4 style="margin-bottom: 30px;">Thông tin</h4>
                        <div class="input-group input-group-icon">
                            <input type="text" placeholder="Nhập tên đầy đủ" name="fullName" required/>
                            <div class="input-icon"><i class="fa fa-user"></i></div>
                        </div>
                        <div class="input-group input-group-icon">
                            <input type="email" placeholder="Nhập email" name="email" required/>
                            <div class="input-icon"><i class="fa fa-envelope"></i></div>
                        </div>
                        <div class="input-group input-group-icon">
                            <input type="password" placeholder="Nhập mật khẩu" name="password" required/>
                            <div class="input-icon"><i class="fa fa-key"></i></div>
                        </div>
                        <div class="input-group input-group-icon">
                            <input type="text" placeholder="Nhập địa chỉ" name="address"/>
                            <div class="input-icon"><i class="fa fa-envelope"></i></div>
                        </div>
                        <div class="input-group input-group-icon">
                            <input type="text" placeholder="Nhập số điện thoại" name="phoneNumber"/>
                            <div class="input-icon"><i class="fa fa-phone"></i></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-half">
                            <h4>Giới tính</h4>
                            <div class="input-group gender">
                                <input type="radio" name="gender" value="Male" id="gender-male"/>
                                <label for="gender-male">Nam</label>
                                <input type="radio" name="gender" value="Female" id="gender-female"/>
                                <label for="gender-female">Nữ</label>
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
</div>
