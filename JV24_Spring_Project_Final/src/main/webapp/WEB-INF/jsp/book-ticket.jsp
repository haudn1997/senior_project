

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="full">
    <div class="main">
        <div class="book-content" style="margin-top: 150px;">
            <!---contact-->
            <div class="container">
                <div class="row">
                    <c:if test="${messages==true}">
                        <div class="row">
                            <div class="col-md-8 col-sm-8 col-xs-12">
                                <div class="alert alert-info">
                                    Phim hoặc phòng hoặc ngày không có trong lịch chiếu. Xin quý khách vui lòng chọn lại!
                                </div>
                            </div>
                        </div>  
                    </c:if>
                    <div class="col-md-8 col-sm-8 col-xs-12">
                        <c:if test="${action == 'filmDetail' || lstDateTime != null || fn:length(lstDateTime)>0}">
                            <div class="part2">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                        <img src="${pageContext.request.getContextPath()}/resources/images/${movie.image}" alt="Movie">
                                    </div>
                                    <div class="col-md-6 col-sm-6 col-xs-12" style="margin-top: 10px;">
                                        <h1>${movie.name}</h1>
                                        <p class="review">Thể loại	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;  ${movie.categoryMovie.name}</p>
                                        <p class="review">Diễn viên	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp; ${movie.actor}</p>
                                        <p class="review">Đạo diễn &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; ${movie.director}</p>
                                        <p class="review">Quốc gia &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; ${movie.country.name}</p>
                                        <p class="review">Ngày chiếu &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; ${movie.dateStartShowing}</p>
                                        <p class="review">Thời lượng &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; ${minutes} phút</p>
                                        <p class="special">${movie.description}</p>
                                        <a class="video" href="${pageContext.request.getContextPath()}/watch-trailer/${movie.id}"><i class="video1"></i>WATCH TRAILER</a>
                                        <a class="book" href="#"><i class="book1"></i>BOOK TICKET</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <div class="part3">
                            <form action="${pageContext.request.getContextPath()}/searchFilm" method="POST">
                                <h3>chọn theo phim</h3>
                                <p class="border select-film"></p>
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-xs-12">
                                        <c:if test="${action == 'bookTicket'}">
                                            <select name="filmId">
                                                <option>Chọn phim</option>
                                                <c:forEach items="${lstMovie}" var="m">
                                                    <option value="${m.id}">${m.name}</option>
                                                </c:forEach>
                                            </select>
                                        </c:if>
                                        <c:if test="${action == 'dateTime'}">
                                            <c:if test="${lstDateTime == null && fn:length(lstDateTime)<=0}">
                                                <select name="filmId">
                                                    <option>Chọn phim</option>
                                                    <c:forEach items="${lstMovie}" var="m">
                                                        <option value="${m.id}">${m.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </c:if>
                                            <c:if test="${lstDateTime != null && fn:length(lstDateTime)>0}">
                                                <select name="filmId">
                                                    <c:forEach items="${lstMovie}" var="m">
                                                        <c:forEach items="${lstDateTime}" var="d">
                                                            <c:if test="${d.movie.id == m.id}">
                                                                <option value="${m.id}" selected>${m.name}</option>
                                                            </c:if>
                                                        </c:forEach>

                                                    </c:forEach>
                                                </select>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${action == 'filmDetail'}">
                                            <select name="filmId">
                                                <option value="${movie.id}">${movie.name}</option>
                                            </select>
                                        </c:if>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-xs-12">
                                        <c:if test="${lstDateTime == null && fn:length(lstDateTime)<=0}">
                                            <select name="roomId">
                                                <option>Chọn phòng</option>
                                                <c:forEach items="${lstRoom}" var="r">
                                                    <option value="${r.id}">${r.name}</option>
                                                </c:forEach>
                                            </select>
                                        </c:if>
                                        <c:if test="${lstDateTime != null && fn:length(lstDateTime)>0}">
                                            <select name="roomId">
                                                <c:forEach items="${lstRoom}" var="r">
                                                    <c:forEach items="${lstDateTime}" var="d">
                                                        <c:if test="${d.room.id == r.id}">
                                                            <option value="${r.id}" selected>${r.name}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>
                                            </select>
                                        </c:if>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-xs-12" >

                                        <input type="date" class="form-control" value="${date}" name="date" id="date"/>
                                    </div>

                                    <div class="col-md-3 col-sm-3 col-xs-12">
                                        <input type="submit" value="Search"/>
                                    </div>
                                </div>
                            </form>
                            <c:if test="${action == 'dateTime'}">
                                <div class="cinema">
                                    <div class="title-cinema">
                                        <h5 class="ng-binding">Chọn Suất</h5>
                                    </div>                         
                                    <div class="item-cinema">
                                        <div class="row">
                                            <div class="col-md-3 col-sm-3 col-xs-12">
                                                <label class="ng-binding">2D -&nbsp;Phụ đề </label>
                                            </div>
                                            <div class="col-md-9 col-sm-9 col-xs-12">
                                                <div class="row">
                                                    <c:forEach items="${lstDateTime}" var="d">
                                                        <div class="col-md-4 col-sm-4 col-xs-12" id="time1">
                                                            <a href="choose-ticket/${d.id}"><span id="time"><fmt:formatDate value="${d.time}" pattern="HH:mm"/></span></a>
                                                        </div>
                                                    </c:forEach>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12">
                        <div style="margin-left: 20px;">
                            <h3>Phim đang chiếu</h3>
                            <p class="border select-film"></p>
                        </div>
                        <div class="right-content">
                            <ul>
                                <c:forEach items="${lstMovie}" var="m">
                                    <li class="span4 mix web">
                                        <div class="thumbnail">
                                            <img src="${pageContext.request.getContextPath()}/resources/images/${m.image}" alt="Movie">
                                            <a class="more show_hide" rel="#slidingDiv" href="${pageContext.request.getContextPath()}/book-ticket-film/${m.id}">
                                                <i class="icon-plus">Book Ticket</i>
                                            </a>

                                            <div class="mask"></div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</div>