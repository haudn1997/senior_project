

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
            <div class="row">
                <div class="row">
                    <div class="col-md-6 col-xs-5" >       
                    </div>
                    <div class="col-md-6 col-xs-5">
                        <div class="row">
                            <div class="col-md-9 col-xs-9" style="" >
                                <form action="${pageContext.request.getContextPath()}/admin/searchMovie" method="post" class="form-inline">
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-md-7 col-xs-6">
                                            <input type="text" name="searchText" class="form-control">
                                        </div>
                                        <div class="col-md-4 col-xs-6" style="margin-left: -80px;">
                                            <button class="btn btn-default col-md-4 col-xs-6" id="btn1" style="width: 40px" ><span><i class="glyphicon glyphicon-search"></i></span> </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-3 col-xs-3"  id="content">
                                <button class="btn btn-success" style="margin-top: 20px;margin-bottom: 20px" onclick="location.href = '${pageContext.request.getContextPath()}/admin/add-movie'">Thêm Phim</button>
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
                    <div class="col-md-12 col-xs-12" id="tableMovie">
                        <div class="table-responsive" >
                            <table class="table table-bordered" style="text-align: center">
                                <tr>
                                    <th style="text-align: center;">ID</th>
                                    <th style="text-align: center;">Name</th>
                                    <th style="text-align: center;">Actor</th>
                                    <th style="text-align: center;">Director</th>   
                                    <th style="text-align: center;">Date Start</th>
                                    <th style="text-align: center;">Time </th>
                                    <th style="text-align: center;">Country </th>
                                    <th style="text-align: center;">Category Movie </th>
                                    <th style="text-align: center;">Action</th>
                                </tr>
                                <c:if test="${lstMovie.content!= null && fun:length(lstMovie.content)>0}">
                                    <c:forEach items="${lstMovie.content }" var="u">
                                        <tr>
                                            <td>${u.id}</td>
                                            <td>${u.name}</td>
                                            <td>${u.actor}</td>
                                            <td>${u.director}</td>
                                            <td>${u.dateStartShowing}</td>
                                            <td>${u.time}</td>
                                            <td>${u.country.name}</td>
                                            <td>${u.categoryMovie.name}</td>
                                            <td>
                                                <button class="btn btn-primary" onclick="location.href = '${pageContext.request.getContextPath()}/admin/edit-movie/${u.id}'"> Sửa</button>
                                                <button class="btn btn-danger" onclick="location.href = '${pageContext.request.getContextPath()}/admin/deleteMovie/${u.id}'"> Xóa</button>      
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </table>
                        </div>
                    </div>
                </div>
                <div style="margin-left: 580px; margin-bottom: 20px;">
                    <ul class="pagination modal-1">
                        <c:if test="${page > 1}">
                            <li><a href="${pageContext.request.getContextPath()}/admin/?page=${page-1}" class="prev">&laquo</a></li>
                            </c:if>

                        <c:forEach begin="1" end="${lstMovie.totalPages}"  var="i">            
                            <c:if test="${i==page}">
                                <li><a class="active" href="${pageContext.request.getContextPath()}/admin/?page=${i}">${i}</a></li>
                                </c:if>
                                <c:if test="${i!=page}">
                                <li>
                                    <a href="${pageContext.request.getContextPath()}/admin/?page=${i}" >${i}</a>
                                </li>
                            </c:if>
                            <c:set value="${i}" var="total"/>
                        </c:forEach>
                        <c:if test="${page < total}">
                            <li><a href="${pageContext.request.getContextPath()}/admin/?page=${page+1}" class="next">&raquo;</a></li> 
                            </c:if>

                    </ul>                
                </div>
            </div>
        </div>
    </div>

</div>