<%-- 
    Document   : homeAdmin
    Created on : Sep 28, 2018, 1:05:36 PM
    Author     : PC
--%>

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
            <div class="row">
                <div class="row">
                    <div class="col-md-6 col-xs-5" >
                        <form action="${pageContext.request.getContextPath()}/admin/categoryMovie" method="post" class="form-inline">
                            <div class="form-group" style="margin-top: 20px;" >
                                <div class="row">
                                    <div class="col-sm-2">
                                        <label style="padding-top: 10px; padding-right: 5px;">Category:</label>
                                    </div>
                                    
                                    <div class="col-sm-6">
                                        <select name="categoryMovie.id" class="form-control">
                                            <c:forEach items="${lstCategoryMovie}" var="c">
                                                <c:if test="${movie.categoryMovie.id == c.id}">
                                                    <option value="${c.id}" selected=""> ${c.name} </option>
                                                </c:if>
                                                <c:if test="${movie.categoryMovie.id != c.id}">
                                                    <option value="${c.id}"> ${c.name} </option>
                                                </c:if>
                                            </c:forEach>
                                        </select>

                                    </div>
                                    <div class="col-sm-4">
                                        <button class="btn btn-default" id="btn1" >Search</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 col-xs-5">
                        <div class="row">
                            <div class="col-md-9 col-xs-9" style="" >
                                <form action="${pageContext.request.getContextPath()}/admin/searchMovie" method="post" class="form-inline">
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-md-7 col-xs-6">
                                            <input type="text" name="searchText" class="form-control">
                                        </div>
                                        <div class="col-md-4 col-xs-6">
                                            <button class="btn btn-default" id="btn1">Search</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-3 col-xs-3"  id="content">
                                <button class="btn btn-success" style="margin-top: 20px;margin-bottom: 20px" onclick="location.href = '${pageContext.request.getContextPath()}/admin/add-movie'">Add Movie</button>
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
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Actor</th>
                                    <th>Director</th>
                                    <th>Images</th>
                                    <th>Date Start</th>
                                    <th>Link</th>
                                    <th>Time </th>
                                    <th>Country </th>
                                    <th>Category Movie </th>
                                    <th>Action</th>
                                </tr>
                                <c:if test="${lstMovie.content!= null && fun:length(lstMovie.content)>0}">
                                    <c:forEach items="${lstMovie.content }" var="u">
                                        <tr>
                                            <td>${u.id}</td>
                                            <td>${u.name}</td>
                                            <td>${u.actor}</td>
                                            <td>${u.director}</td>
                                            <td>${u.image}</td>
                                            <td>${u.dateStartShowing}</td>
                                            <td>${u.link}</td>
                                            <td>${u.time}</td>
                                            <td>${u.country.name}</td>
                                            <td>${u.categoryMovie.name}</td>
                                            <td>
                                                <button class="btn btn-danger" onclick="location.href = '${pageContext.request.getContextPath()}/admin/deleteMovie/${u.id}'"> Delete</button>
                                                <button class="btn btn-primary" onclick="location.href = '${pageContext.request.getContextPath()}/admin/edit-movie/${u.id}'"> Edit</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </table>
                        </div>
                    </div>
                </div>
                <div style="margin-left: 400px; margin-bottom: 20px;">
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