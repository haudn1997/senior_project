<%-- 
    Document   : showing-movie
    Created on : Oct 13, 2018, 6:09:00 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="full">     
    <div class="main"> 
        <div id="slider">
            <div class="viewer">
                <div class="reel">
                    <div class="slide">
                        <img src="${pageContext.request.getContextPath()}/resources/images/slider1.jpg" alt=""/>
                    </div>
                    <div class="slide">
                        <img src="${pageContext.request.getContextPath()}/resources/images/slider1.jpg" alt=""/>
                    </div>
                    <div class="slide">
                       <img src="${pageContext.request.getContextPath()}/resources/images/slider1.jpg" alt=""/>
                    </div>
                </div>
            </div>
            <div class="indicator">
                <span>1</span>
                <span>2</span>
                <span>3</span>
            </div>
        </div>
        <!--                <div class="video">
                            <iframe  src="https://www.youtube.com/embed/2LqzF5WauAw" frameborder="0" allowfullscreen></iframe>
                        </div>-->
        <div class="container">

            <div class="row">
                <c:forEach items="${lstShowing}" var="s">
                    <div class="col-md-4 col-sm-4 col-xs-12" style="margin-bottom: 20px;">
                        <div class="thumbnail">
                            <img src="<c:url value="resources/images/${s.image}"/>" alt="Movie">
                            <a class="more show_hide" rel="#slidingDiv" href="${pageContext.request.getContextPath()}/book-ticket-film/${s.id}">
                                <i class="icon-plus">Book Ticket</i>
                            </a>

                            <div class="mask"></div>

                        </div>
                        <div class="name-film">
                            <a href="${pageContext.request.getContextPath()}/showdetail/${s.id}">${s.name}</a>
                        </div>

                    </div>
                </c:forEach>
            </div>

        </div>
    </div>
</div>
<div class="clearfix"></div>
<script src="${pageContext.request.getContextPath()}/resources/js/slider.js"></script>