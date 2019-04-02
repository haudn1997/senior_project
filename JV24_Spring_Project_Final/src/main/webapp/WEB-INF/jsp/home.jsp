<%-- 
    Document   : home1
    Created on : Sep 23, 2018, 8:18:22 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
    * {box-sizing: border-box;}
    body {font-family: Verdana, sans-serif;}
    .mySlides {display: none;}
    img {vertical-align: middle;}

    /* Slideshow container */
    .slideshow-container {
        max-width: 1000px;
        position: relative;
        margin: auto;
    }

    /* Caption text */
    .text {
        color: #f2f2f2;
        font-size: 15px;
        padding: 8px 12px;
        position: absolute;
        bottom: 8px;
        width: 100%;
        text-align: center;
    }

    /* Number text (1/3 etc) */
    .numbertext {
        color: #f2f2f2;
        font-size: 12px;
        padding: 8px 12px;
        position: absolute;
        top: 0;
    }

    /* The dots/bullets/indicators */
    .dot {
        height: 15px;
        width: 15px;
        margin: 0 2px;
        background-color: #bbb;
        border-radius: 50%;
        display: inline-block;
        transition: background-color 0.6s ease;
    }

    .active {
        background-color: #717171;
    }

    /* Fading animation */
    .fade {
        -webkit-animation-name: fade;
        -webkit-animation-duration: 1.5s;
        animation-name: fade;
        animation-duration: 1.5s;
    }

    @-webkit-keyframes fade {
        from {opacity: .4} 
        to {opacity: 1}
    }

    @keyframes fade {
        from {opacity: .4} 
        to {opacity: 1}
    }

    /* On smaller screens, decrease text size */
    @media only screen and (max-width: 300px) {
        .text {font-size: 11px}
    }
</style>
<div class="full">     
    <div class="main"> 
        <div class="container">
            <div class="row">
                <div class="slideshow-container">
                    <div class="mySlides fade">
                        <img src="${pageContext.request.getContextPath()}/resources/images/slider1.jpg" style="width:100%">
                    </div>

                    <div class="mySlides fade">
                        <img src="${pageContext.request.getContextPath()}/resources/images/slider2.jpg" style="width:100%">
                    </div>

                    <div class="mySlides fade">
                        <img src="${pageContext.request.getContextPath()}/resources/images/slider1.jpg" style="width:100%">
                    </div>

                </div>
                <br>

                <div style="text-align:center">
                    <span class="dot"></span> 
                    <span class="dot"></span> 
                    <span class="dot"></span> 
                </div>
            </div>
            <div class="row">
                <c:forEach items="${lstMovies.content}" var="s">
                    <div class="col-md-4 col-sm-4 col-xs-12" style="margin-bottom: 20px;">
                        <div class="thumbnail">
                            <img src='<c:url value="resources/images/${s.image}"/>' alt="Movie">
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

            <hr/>
            <div style="margin-left: 500px; margin-bottom: 20px;">
                <ul class="pagination modal-1">
                    <c:if test="${page > 1}">
                        <li><a href="${pageContext.request.getContextPath()}/home?page=${page-1}" class="prev">&laquo</a></li>
                    </c:if>

                    <c:forEach begin="1" end="${lstMovies.totalPages}"  var="i">            
                        <c:if test="${i==page}">
                            <li><a class="active" href="${pageContext.request.getContextPath()}/home?page=${i}">${i}</a></li>
                            </c:if>
                            <c:if test="${i!=page}">
                            <li>
                                <a href="${pageContext.request.getContextPath()}/home?page=${i}" >${i}</a>
                            </li>
                        </c:if>
                        <c:set value="${i}" var="total"/>
                    </c:forEach>
                    <c:if test="${page < total}">
                        <li><a href="${pageContext.request.getContextPath()}/home?page=${page+1}" class="next">&raquo;</a></li> 
                    </c:if>

                </ul>                
            </div>

            <div class="clearfix"></div>
        </div>
    </div>
</div>
<div class="clearfix"></div>
<script>
    var slideIndex = 0;
    showSlides();

    function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        var dots = document.getElementsByClassName("dot");
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > slides.length) {
            slideIndex = 1
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        slides[slideIndex - 1].style.display = "block";
        dots[slideIndex - 1].className += " active";
        setTimeout(showSlides, 2000); // Change image every 2 seconds
    }
</script>