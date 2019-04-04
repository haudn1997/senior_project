
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link type="text/css" rel="stylesheet" href="${pageContext.request.getContextPath()}/webjars/bootstrap/3.3.7/css/bootstrap.min.css"/>

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
            <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center">
                <h1 style="color: #23527c">THÊM VÀ CẬP NHẬT LỊCH CHIẾU PHIM</h1>
            </div>
            <c:if test="${message != null && message != ''}">
                <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center">
                    <div class="alert alert-danger">${message}</div>
                </div>
            </c:if>
            <div class="col-xs-12 col-sm-12 col-md-12" style="margin-top: 50px;">
                <f:form action="${pageContext.request.getContextPath()}/admin/${action}" method="post" modelAttribute="movieSchdule" class="form-horizontal">
                    <c:if test="${action== 'update-movieSchedule'}">
                        <input type="text" hidden name="id" value="${movieSchedule.id}"/>
                    </c:if>
                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Ngày chiếu:<span style="color: red">(*)</span></label>
                        <div class="col-xs-8 col-sm-8">
                            <input name="date"  type="date"  class="form-control" placeholder="yyyy-MM-dd" required=""  value="${movieSchedule.date}"/>                                                          <f:errors path="lastname" cssClass="fielError"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Thời gian chiếu:<span style="color: red">(*)</span></label>
                        <div class="col-xs-8 col-sm-8">
                            <input name="time"  type="text"  class="form-control" placeholder="HH:mm:ss" required=""  value="${movieSchedule.time}"/>                                                          <f:errors path="lastname" cssClass="fielError"/>
                        </div>
                    </div>


                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Phim:<span style="color: red">(*)</span> </label>
                        <div class="col-xs-8 col-sm-8">
                            <select name="movie.id" class="form-control" required="" >
                                <option>Chọn phim</option>
                                <c:forEach items="${lstMovie}" var="c">
                                    <c:if test="${movieSchedule.movie.id == c.id}">
                                        <option value="${c.id}" selected=""> ${c.name} </option>
                                    </c:if>
                                    <c:if test="${movieSchedule.movie.id != c.id}">
                                        <option value="${c.id}"> ${c.name} </option>
                                    </c:if> 
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 col-xs-4  control-lable">Phòng:<span style="color: red">(*)</span> </label>
                        <div class="col-xs-8 col-sm-8">
                            <select name="room.id" class="form-control" required="" >
                                <option>Chọn phòng</option>
                                <c:forEach items="${lstRoom}" var="c">
                                    <c:if test="${movieSchedule.room.id == c.id}">
                                        <option value="${c.id}" selected=""> ${c.name} </option>
                                    </c:if>
                                    <c:if test="${movieSchedule.room.id != c.id}">
                                        <option value="${c.id}"> ${c.name} </option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="text-align: center">
                        <input type="submit" class="btn btn-danger" value="Xong"/>
                    </div>
                </f:form>
            </div>
        </div>
    </div>

</div>

