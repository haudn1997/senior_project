

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

<style type="text/css">
    body{
        min-height:200px;

        height: auto;
    }
    tr:nth-child(odd){
        background-color: #f0f0f0;

    }
    tr:hover{
        background-color: #DDD;
    }
    .affix{
        top: 0;
        width: 100%;
        z-index: 9999 !important;

    }
</style>


<div class="main-panel">
    <nav class="navbar navbar-default navbar-fixed">
        <div class="container-fluid">
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
            <div class="tab-content" style="margin-top: 20px; margin-bottom: 20px">
                <div class="row">
                    <div class="col-md-6 col-xs-6"  style="margin-top: 10px; margin-bottom: 10px;text-align: left">

                    </div>
                    <div class="col-md-6 col-xs-6">
                        <div class="row">
                            <div class="col-md-7 col-xs-7 " style="" >
                                <form action="${pageContext.request.getContextPath()}/admin/searchUser" method="post" class="form-inline">
                                    <div class="form-groud" style="margin-top: 20px;">
                                        <input type="text" name="searchText" class="form-control col-md-8 col-xs-6" style="width: 110px; margin-right: 10px">
                                        <button class="btn btn-default col-md-4 col-xs-6" id="btn1" style="width: 40px" ><span><i class="glyphicon glyphicon-search"></i></span> </button>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-5 col-xs-5" id="content">
                                <button class="btn btn-success" style="margin-top: 20px; margin-bottom: 20px; margin-left: 50px;" onclick="location.href = '${pageContext.request.getContextPath()}/admin/add-user'">Thêm Người Dùng</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-xs-12" id="load1">
                        <c:if test="${message != null && message != ''}">
                            <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center" >
                                <div class="alert alert-danger">${message} </div>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-xs-12" id="tableMovie" >
                        <div class="table-responsive" >
                            <table class="table table-bordered" style="text-align: center">
                                <tr>
                                    <th style="text-align: center;">ID</th>
                                    <th style="text-align: center;">Name</th>
                                    <th style="text-align: center;">Email</th>
                                    <th style="text-align: center;">Gender</th>
                                    <th style="text-align: center;">Address</th>
                                    <th style="text-align: center;">PhoneNumber</th>
                                    <th style="text-align: center;">Active </th>
                                    <th style="text-align: center;">Action</th>
                                </tr>
                                <c:if test="${lstUser!= null && fun:length(lstUser)>0}">
                                    <c:forEach items="${lstUser}" var="u">
                                        <tr>
                                            <td>${u.id}</td>
                                            <td>${u.fullName}</td>
                                            <td>${u.email}</td>
                                            <td>${u.gender}</td>
                                            <td>${u.address}</td>
                                            <td>${u.phoneNumber}</td>
                                            <td>${u.active}</td>
                                            <td>
                                                <button class="btn btn-primary" onclick="location.href = '${pageContext.request.getContextPath()}/admin/edit-user/${u.id}'" > Sửa</button>
                                                <button class="btn btn-danger" onclick="location.href = '${pageContext.request.getContextPath()}/admin/delete-user/${u.id}'"> Xóa</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
