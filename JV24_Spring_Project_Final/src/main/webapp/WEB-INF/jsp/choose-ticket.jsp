

<%@page import="java.util.List"%>
<%@page import="com.mycompany.jv24_spring_project_final.entities.TicketDetailEntity"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="full">
    <div class="main">
        <div class="choose-ticket" style="margin-bottom: 50px; margin-top: 150px;">
            <div class="container">
                <c:if test="${message!=null && message!=''}">
                    <div class="row">
                        <div class="col-md-8 col-sm-8 col-xs-12">
                            <div class="alert alert-info">
                                ${message}
                            </div>
                        </div>
                    </div>
                </c:if>
                <div class="row">
                    <div class="col-md-8 col-sm-8 col-xs-12">
                        <section ng-show="step == & quot;select - ticket & quot;" class="booking-ticket">
                            <h2 id="choose-ticket-food" class="booking-title">Chọn vé/thức ăn</h2>
                            <div class="table-responsive">
                                <table class="table table-striped booking-ticket-table">
                                    <colgroup>
                                        <col width="45%">
                                        <col width="20%">
                                        <col width="20%">
                                        <col width="15%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>Loại vé</th>
                                            <th>Số lượng</th>
                                            <th class="price">Giá (VNĐ)</th>
                                            <th class="action">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody class="ng-pristine ng-untouched ng-valid ng-isolate-scope ng-not-empty">
                                        <c:forEach items="${lstCategory}" var="c">
                                        <form action="${pageContext.request.getContextPath()}/update-ticket/${movieScheduleId}" method="POST"> 
                                            <tr class="ng-scope">

                                                <td>
                                                    <input type="text" hidden name="ticketId" value="${c.id}"/>
                                                    <p><b class="ng-binding">${c.name}</b></p>
                                                    <p class="des-corn ng-binding">Vé 2D</p>
                                                </td>
                                                <td>
                                                    <div class="input-group input-booking">
                                                        <c:if test="${bookTicketSelected==null || fn:length(bookTicketSelected)<=0}">
                                                            <input style="width: 60px" type="number" min="0" value="0" name="quantity">
                                                        </c:if>
                                                        <c:if test="${bookTicketSelected!=null && fn:length(bookTicketSelected)>0}">
                                                            <c:set value="false" var="isExist"/>
                                                            <c:forEach items="${bookTicketSelected}" var="ticketSelected">
                                                                <c:if test="${ticketSelected.categoryTicket.id == c.id}">
                                                                    <c:set value="true" var="isExist"/>
                                                                    <c:set value="${ticketSelected.quantity}" var="quantity"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${isExist==true}">
                                                                <input style="width: 60px" type="number" min="0" value="${quantity}" name="quantity">
                                                            </c:if>
                                                            <c:if test="${isExist==false}">
                                                                <input style="width: 60px" type="number" min="0" value="0" name="quantity">
                                                            </c:if>

                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td class="ng-binding"><span name="price">${c.price}</span></td>
                                                <td>
                                                    <input type="submit" value="Mua" />
                                                </td>
                                            </tr>
                                        </form>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <table class="table table-striped booking-ticket-table">
                                    <colgroup>
                                        <col width="45%">
                                        <col width="20%">
                                        <col width="20%">
                                        <col width="15%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>Combo</th>
                                            <th>Số lượng</th>
                                            <th class="price">Giá (VNĐ)</th>
                                            <th class="action">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody class="ng-pristine ng-untouched ng-valid ng-isolate-scope ng-not-empty">
                                        <c:forEach items="${lstCombo}" var="b">
                                        <form action="${pageContext.request.getContextPath()}/update-combo/${movieScheduleId}" method="POST"> 
                                            <tr class="ng-scope">
                                                <td>
                                                    <input type="text" hidden name="comboId" value="${b.id}"/>
                                                    <p><b class="ng-binding">${b.name}</b></p>
                                                    <p class="des-corn ng-binding">${b.description}</p>
                                                </td>
                                                <td>
                                                    <div class="input-group input-booking">

                                                        <c:if test="${bookComboSelected==null || fn:length(bookComboSelected)<=0}">
                                                            <input style="width: 60px" type="number" min="0" value="0" name="quantity">
                                                        </c:if>
                                                        <c:if test="${bookComboSelected!=null && fn:length(bookComboSelected)>0}">
                                                            <c:set value="false" var="isExist"/>
                                                            <c:forEach items="${bookComboSelected}" var="comboSelected">
                                                                <c:if test="${comboSelected.combo.id == b.id}">
                                                                    <c:set value="true" var="isExist"/>
                                                                    <c:set value="${comboSelected.quantity}" var="quantity"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${isExist==true}">
                                                                <input style="width: 60px" type="number" min="0" value="${quantity}" name="quantity">
                                                            </c:if>
                                                            <c:if test="${isExist==false}">
                                                                <input style="width: 60px" type="number" min="0" value="0" name="quantity">
                                                            </c:if>

                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td class="ng-binding"><span name="price">${b.price}</span></td>
                                                <td>
                                                    <input type="submit" value="Mua" />
                                                </td>
                                            </tr>
                                        </form>
                                    </c:forEach>
                                    </tbody>
                                    <tr class="total">
                                    <input type="text" hidden id="total" name="total"/>

                                    <td colspan="3" class="ng-binding">Tổng</td>
                                    <c:if test="${bookSession!=null}">
                                        <td class="ng-binding"><span id="total-span">${bookSession.totalPrice}</span></td>
                                        </c:if>
                                        <c:if test="${bookSession==null}">
                                        <td class="ng-binding"><span id="total-span">0</span></td>
                                    </c:if>

                                    </tr>
                                </table>                               
                            </div>      

                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12">
                        <div style="margin-left: 20px;">
                            <h3 style="color: #5261ac">THÔNG TIN VỀ VÉ</h3>
                            <p class="border"></p>
                        </div>
                        
                        <div class="right-content">
                            <ul>
                                <li>
                                    <div class="thumbnail">
                                        <img src="${pageContext.request.getContextPath()}/resources/images/${movieSchedule.movie.image}" alt=""/>
                                    </div>
                                    <div class="name-film">
                                        <a href="${pageContext.request.getContextPath()}/showdetail/${movieSchedule.movie.id}">${movieSchedule.movie.name}</a>
                                    </div>
                                </li>
                                <li>
                                    <span style="color: #007bff; font-size: 15px;">Suất chiếu</span> : ${movieSchedule.time} | ${movieSchedule.date}
                                </li>
                                <li>
                                    <span style="color: #007bff; font-size: 15px;">Rạp</span> : ${movieSchedule.room.name}

                                </li>
                                <li>
                                    <button onclick="location.href = '${pageContext.request.getContextPath()}/choose-seat/${movieSchedule.room.id}/${movieSchedule.movie.id}/${movieSchedule.id}'">Tiếp tục</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>

</div>
<script src="${pageContext.request.getContextPath()}/resources/js/total-price.js" type="text/javascript"></script>