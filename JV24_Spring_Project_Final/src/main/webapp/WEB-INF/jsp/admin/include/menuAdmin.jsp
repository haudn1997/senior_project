
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script>
    function display() {
        document.getElementById("demo").innerHTML = Date();
    }
</script>

<div class="sidebar" data-color="purple" data-image="assets/img/sidebar-5.jpg">
    <div class="sidebar-wrapper">
        <div class="logo">
            <a href="${pageContext.request.getContextPath()}/admin/home">
                <img src="${pageContext.request.getContextPath()}/resources/images/logo.png" alt="" />
            </a>
        </div>

        <ul class="nav">
            <li class="">
                <a href="${pageContext.request.getContextPath()}/admin/home">
                    <i class="fas fa-film"></i>
                    <p>Movie</p>
                </a>
            </li>

            <li class="">
                <a href="${pageContext.request.getContextPath()}/admin/user">
                    <i class="far fa-user"></i>
                    <p>User</p>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.getContextPath()}/admin/movieschedule">
                    <i class="fas fa-calendar-alt"></i>
                    <p>Movie Schedule</p>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.getContextPath()}/admin/viewTicket">
                    <i class="fas fa-download"></i>
                    <p>Export</p>
                </a>
            </li>
        </ul>
    </div>
    <div class="sidebar-background" style="background-image: url(${pageContext.request.getContextPath()}/resources/images/sidebar-5.jpg);"></div>
</div>
<script>
        $(document).ready(function(){
            $("li").click(function(){   
                $(this).attr("class","active");
            });            
        });
</script>