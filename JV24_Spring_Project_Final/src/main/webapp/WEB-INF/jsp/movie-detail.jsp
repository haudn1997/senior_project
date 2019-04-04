
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<div class="full">    
    <div class="main">
        <div class="header"> 
            <div class="header-img">
                <img src="${pageContext.request.getContextPath()}/resources/images/${movie.image}" alt="Movie">
            </div>
            <div class="header-info">
                <h1>${movie.name}</h1>
                <p class="review">Thể loại	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;  ${movie.categoryMovie.name}</p>
                <p class="review">Diễn viên	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp; ${movie.actor}</p>
                <p class="review">Đạo diễn &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; ${movie.director}</p>
                <p class="review">Quốc gia &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; ${movie.country.name}</p>
                <p class="review">Ngày chiếu &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; ${movie.dateStartShowing}</p>
                <p class="review">Thời lượng &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; ${minutes} phút</p>
                <p class="special">${movie.description}</p>
                <a class="video" href="${pageContext.request.getContextPath()}/watch-trailer/${movie.id}"><i class="video1"></i>WATCH TRAILER</a>
                <a class="book" href="${pageContext.request.getContextPath()}/book-ticket-film/${movie.id}"><i class="book1"></i>BOOK TICKET</a>
            </div>
        </div>
    </div>
</div>
