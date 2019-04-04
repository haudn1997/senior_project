

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="full">
    <div class="main">
        <div class="choose-ticket" style="margin-bottom: 50px; margin-top: 150px;">
            <div class="container">
                <c:if test="${message!=null}">
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

                        <section class="booking-ticket">
                            <h2 id="choose-ticket-food" class="booking-title">Chọn ghế</h2>
                            <div class="seat-map-wrapper">
                                <table>
                                    <tbody>
                                        <c:forEach items="${lstPosition}" var="r">
                                            <tr>
                                                <td class="row-seat">${r.key}</td>
                                                <c:forEach items="${r.value}" var="p">
                                            <form action="${pageContext.request.getContextPath()}/book-seat/${roomId}/${movieId}/${scheduleId}" method="POST">
                                                <td><input type="text" name="positionId" hidden value="${p.id}"/></td>
                                                    <c:if test="${(lstBookChair==null) && (fn:length(lstSeatSelected)<=0)}"> 
                                                    <td class="number-seat"><input type="submit" id="numberSeat" name="numberSeat" value="${p.numberSeat}"/></td>
                                                    </c:if>

                                                <c:if test="${(lstBookChair!=null) && (fn:length(lstSeatSelected)<=0)}">
                                                    <c:set value="1" var="isExist"/>
                                                    <c:forEach items="${lstBookChair}" var="b">
                                                        <c:if test="${b.positionSeat.id == p.id}">
                                                            <c:set value="2" var="isExist"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${isExist==1}">
                                                        <td class="number-seat"><input type="submit" id="numberSeat" name="numberSeat" value="${p.numberSeat}"/></td>
                                                        </c:if>
                                                        <c:if test="${isExist==2}">
                                                        <td class="number-seat"><input type="submit" id="selected-seat" name="numberSeat" value="${p.numberSeat}" disabled/></td>
                                                        </c:if> 
                                                    </c:if>

                                                <c:if test="${(fn:length(lstSeatSelected)>0) && (lstBookChair==null)}">
                                                    <c:set value="1" var="isExist"/>
                                                    <c:forEach items="${lstSeatSelected}" var="s">
                                                        <c:forEach items="${s.value}" var="l">
                                                            <c:if test="${l.positionSeat.id == p.id}">
                                                                <c:set value="2" var="isExist"/>
                                                            </c:if>
                                                        </c:forEach>

                                                    </c:forEach>
                                                    <c:if test="${isExist==1}">
                                                        <td class="number-seat"><input type="submit" id="numberSeat" name="numberSeat" value="${p.numberSeat}"/></td>
                                                        </c:if>
                                                        <c:if test="${isExist==2}">
                                                        <td class="number-seat"><input type="submit" id="sold-seat" name="numberSeat" value="${p.numberSeat}" disabled/></td>
                                                        </c:if> 
                                                    </c:if>

                                                <c:if test="${(lstBookChair!=null) && (fn:length(lstSeatSelected)>0)}"> 
                                                    <c:set value="0" var="isExist"/>
                                                    <c:forEach items="${lstBookChair}" var="b">
                                                        <c:if test="${b.positionSeat.id == p.id}">
                                                            <c:set value="1" var="isExist"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:forEach items="${lstSeatSelected}" var="s">
                                                        <c:forEach items="${s.value}" var="l">
                                                            <c:if test="${l.positionSeat.id == p.id}">
                                                                <c:set value="2" var="isExist"/>
                                                            </c:if>
                                                        </c:forEach>

                                                    </c:forEach>
                                                    <c:if test="${isExist==0}">
                                                        <td class="number-seat"><input type="submit" id="numberSeat" name="numberSeat" value="${p.numberSeat}"/></td>
                                                        </c:if>
                                                        <c:if test="${isExist==1}">
                                                        <td class="number-seat"><input type="submit" id="selected-seat" name="numberSeat" value="${p.numberSeat}"/></td>
                                                        </c:if>
                                                        <c:if test="${isExist==2}">
                                                        <td class="number-seat"><input type="submit" id="sold-seat" name="numberSeat" value="${p.numberSeat}" disabled/></td>
                                                        </c:if>
                                                    </c:if>
                                            </form>
                                        </c:forEach>
                                        <td class="row-seat">${r.key}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div class="screen">Màn hình</div>
                                <div class="seat-cinema">
                                    <span class="seat-cinema-selected">Ghế đang chọn</span>
                                    <span class="seat-cinema-unavailable">Ghế đã bán</span>
                                    <span class="seat-cinema-normal">Có thể chọn</span>
                                </div>
                            </div>  

                        </section>
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
                                    <button onclick="location.href = '${pageContext.request.getContextPath()}/check-out-info'">Thanh toán</button>
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