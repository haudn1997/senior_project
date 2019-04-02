
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div id="navbar">
    <div class="top-header">
        <div class="container">
            <div class="row">
                <div class="col-md-5 col-sm-5 col-xs-12">
                    <div class="logo">
                        <a href="<c:url value="/" />"><img src="${pageContext.request.getContextPath()}/resources/images/logo.png" alt="" /></a>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4 col-xs-12">
                    <div class="search">
                        <form action="search" method="POST">
                            <input type="text" value="Tìm tên phim" name="searchText" onfocus="this.value = '';" onblur="if (this.value == '') {
                                        this.value = 'Tìm tên phim';
                                    }"/>
                            <input type="submit" value="">
                        </form>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3 col-xs-12">
                    <sec:authorize access='!isAuthenticated()'>
                        <div class="group-login-register">
                            <a href="${pageContext.request.getContextPath()}/login" id="login">Đăng nhập</a>
                            <span class="gach-doc"></span>
                            <a href="${pageContext.request.getContextPath()}/register" id="register">Đăng kí</a>
                        </div>
                    </sec:authorize>
                    <sec:authorize access='isAuthenticated()'>  
                        <div class="group-login-register">
                            <sec:authorize access="hasRole('ROLE_USER')">
                                <span class="email"><sec:authentication property='principal.fullName'/></span>
                            </sec:authorize> 
                            <span class="gach-doc"></span>
                            <a href="<c:url value="/logout"/>">&nbsp;&nbsp;Logout</a>
                        </div>                      
                    </sec:authorize>
                </div>
            </div>
        </div>


        <div class="clearfix"></div>
    </div>

    <div id="menu">
        <ul>
            <li class="first"> </li>
            <li><a href="<c:url value="/" />">Trang chủ</a></li>          
            <li><a href="${pageContext.request.getContextPath()}/book-ticket">Mua vé</a></li>
            <li><a href="${pageContext.request.getContextPath()}/showing">Phim Đang Chiếu</a></li>
            <li><a href="${pageContext.request.getContextPath()}/coming">Phim Sắp Chiếu</a></li>
            <li><a href="${pageContext.request.getContextPath()}/contact">Liên hệ</a></li>
                <sec:authorize access='isAuthenticated()'>  
                <li><a href="${pageContext.request.getContextPath()}/check-out-info">Thanh toán</a></li>
                </sec:authorize>
        </ul>
        <br class="clearfix" />
    </div>
</div>

