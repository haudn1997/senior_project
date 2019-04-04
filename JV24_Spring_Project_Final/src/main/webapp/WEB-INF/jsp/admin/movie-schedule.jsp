
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
    #datepicker{
        width:140px; 
        margin: 0px;
    }
    #datepicker > span:hover{
        cursor: pointer;
    }
    .affix{
        top: 0;
        width: 100%;
        z-index: 9999 !important;

    }
    #tableMovie{
    }
    #example{
    }
    tr:nth-child(odd){
        background-color: #f0f0f0;

    }
    tr:hover{
        background-color: #DDD;
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
            <div class="tab-content" style="margin-top: 10px; margin-bottom: 20px">
                <div class="row">
                    <div class="col-md-6 col-xs-6"  style="margin-top: 20px; margin-bottom: 10px;text-align: left">
                    </div>
                    <div class="col-md-6 col-xs-6" style="text-align: right">
                        <div class="row">
                            <div class="col-md-7 col-xs-7 "  >
                            </div>
                            <div class="col-md-5 col-xs-5"  id="content">
                                <button class="btn btn-success" style="margin-top: 20px;margin-bottom: 20px" onclick="location.href = '${pageContext.request.getContextPath()}/admin/add-movieSchedule'">Thêm Lịch Chiếu Phim</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-xs-12" >
                        <c:if test="${message != null && message != ''}">
                            <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center" >
                                <div class="alert alert-danger">${message}</div>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="tab-pane active" id="phimmoi" >
                    <div class="row">
                        <div class="col-md-12 col-xs-12" id="tableMovie" >
                            <div class="table-responsive" >
                                <table class="table table-bordered" style="text-align: center">
                                    <tr>
                                        <th style="text-align: center;">ID</th>
                                        <th style="text-align: center;">Movie Name</th>
                                        <th style="text-align: center;">Room</th>
                                        <th style="text-align: center;">ShowTime</th>
                                        <th style="text-align: center;">Action</th>
                                    </tr>
                                    <c:if test="${lstMovieSchedule!= null && fun:length(lstMovieSchedule)>0}">
                                        <c:forEach items="${lstMovieSchedule}" var="u">
                                            <tr>
                                                <td>${u.id}</td>
                                                <td>${u.movie.name}</td>
                                                <td>${u.room.name}</td>
                                                <td>${u.date} ${u.time}</td>
                                                <td>
                                                    <button class="btn btn-primary" onclick="location.href = '${pageContext.request.getContextPath()}/admin/edit-movieSchedule/${u.id}'"> Sửa</button>
                                                    <button class="btn btn-danger" onclick="location.href = '${pageContext.request.getContextPath()}/admin/deleteMovieSchedule/${u.id}'"> Xóa</button>                                                   
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

</div>