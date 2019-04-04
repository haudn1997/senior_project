

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
                <div class="col-md-8 col-xs-8" id="load1">
                    <c:if test="${message != null && message != ''}">
                        <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center" >
                            <div class="alert alert-danger">${message} ${fun:length(lstMovie)}</div>
                        </div>
                    </c:if>
                </div>
                <div class="col-md-4 col-xs-4">
                    <a href="${pageContext.request.getContextPath()}/admin/downloadExcel">Download Excel Document</a>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12"  id="tabs" style="margin-top: 10px">
                    <div class="table-responsive" >
                        <table class="table table-bordered" style="text-align: center">
                            <tr>
                                <th style="text-align: center;">ID</th>
                                <th style="text-align: center;">Movie</th>
                                <th style="text-align: center;">Ticket Detail</th>
                                <th style="text-align: center;">CreateAt</th>
                                <th style="text-align: center;">Total Price</th>

                            </tr>
                            <c:if test="${lstTicket!= null && fun:length(lstTicket)>0}">

                                <c:forEach items="${lstTicket}" var="u">
                                    <tr>
                                        <td>${u.id}</td>
                                        <td>${u.movie.name}</td>
                                        <td>
                                            <c:forEach items="${u.ticketDetail}" var="t">
                                                Quantity: ${t.quantity}/Category: ${t.categoryTicket.name}<br>
                                            </c:forEach>
                                        </td>
                                        <td>${u.createAt}</td>
                                        <td>${u.totalPrice}</td>

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