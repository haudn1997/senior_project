

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

<style type="text/css">
    body{
        min-height:auto;

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

<script type="text/javascript" language="javascript">
    $(window).ready(function () {
        $('#load1').bind('load',${message != null && message != ''}, function (event) {
            $('#content').hide();

        });
    });
</script>

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

            <div class="row" style="margin-top: 20px; margin-bottom: 10px;text-align: center">
                <div class="col-md-8 col-xs-6" id="load1">

                    <c:if test="${lstMovie!= null && fun:length(lstMovie)>0}">                     
                        <c:if test="${message != null && message != ''}">
                            <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center" >
                                <div class="alert alert-danger">${message} ${fun:length(lstMovie)}</div>
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${lstUser!= null && fun:length(lstUser)>0}">                     
                        <c:if test="${message != null && message != ''}">
                            <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center" >
                                <div class="alert alert-danger">${message} ${fun:length(lstUser)}</div>
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${lstMovieSchedule!= null && fun:length(lstMovieSchedule)>0}">
                        <c:if test="${message != null && message != ''}">
                            <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center" >
                                <div class="alert alert-danger">${message} ${fun:length(lstMovieSchedule)}</div>
                            </div>
                        </c:if>
                    </c:if>
                </div>
                <div class="col-md-4 col-xs-6" style="text-align: right">
                    <c:if test="${lstMovie!= null && fun:length(lstMovie)>0}">                     
                        <button class="btn btn-primary" onclick="location.href = '${pageContext.request.getContextPath()}/admin/home'"> Continue</button>
                    </c:if>
                    <c:if test="${lstUser!= null && fun:length(lstUser)>0}">                     
                        <button class="btn btn-primary" onclick="location.href = '${pageContext.request.getContextPath()}/admin/user'"> Continue</button>
                    </c:if>
                    <c:if test="${lstMovieSchedule!= null && fun:length(lstMovieSchedule)>0}">
                        <button class="btn btn-primary" onclick="location.href = '${pageContext.request.getContextPath()}/admin/movieschedule'"> Continue</button>
                    </c:if>


                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12"  id="tabs" style="margin-top: 10px">
                    <div class="table-responsive" >
                        <table class="table table-bordered" style="text-align: center">
                            <c:if test="${lstMovie!= null && fun:length(lstMovie)>0}">

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


                                <c:forEach items="${lstMovie}" var="u">
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
                                            <button class="btn btn-danger"> Delete</button>
                                            <button class="btn btn-primary"> Edit</button>
                                        </td>
                                    </tr>

                                </c:forEach>
                            </c:if>

                            <c:if test="${lstUser!= null && fun:length(lstUser)>0}">
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>BirthDay</th>
                                    <th>Gender</th>
                                    <th>address</th>
                                    <th>PhoneNumber</th>
                                    <th>Active </th>
                                    <th>Action</th>
                                </tr>
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
                                            <button class="btn btn-danger"> Delete</button>
                                            <button class="btn btn-primary"> Edit</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${lstMovieSchedule!= null && fun:length(lstMovieSchedule)>0}">

                                <tr>
                                    <th>ID</th>
                                    <th>Movie Name</th>
                                    <th>Room</th>
                                    <th>ShowTime</th>
                                    <th>Action</th>
                                </tr>
                                <c:forEach items="${lstMovieSchedule}" var="u">
                                    <tr>
                                        <td>${u.id}</td>
                                        <td>${u.movie.name}</td>
                                        <td>${u.room.name}</td>
                                        <td>${u.date} ${u.time}</td>
                                        <td>
                                            <button class="btn btn-danger" onclick="location.href = '${pageContext.request.getContextPath()}/admin/deleteMovieSchedule/${u.id}'"> Delete</button>
                                            <button class="btn btn-primary"> Edit</button>
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

