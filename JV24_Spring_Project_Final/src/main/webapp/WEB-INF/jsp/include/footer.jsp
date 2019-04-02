

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<footer class="footer-bg">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                <ul class="list-unstyled clear-margins">
                    <li class="widget-container widget_nav_menu">
                        <h1 class="title-widget">Giới thiệu</h1>
                        <ul>
                            <li>
                                <a href="/ve-chung-toi"><i class="fa fa-angle-double-right"></i> Về chúng tôi</a>
                            </li>
                            <li>
                                <a href="/thoa-thuan-su-dung"><i class="fa fa-angle-double-right"></i> Thoả thuận sử dụng</a>
                            </li>
                            <li>
                                <a href="/quy-che-hoat-dong"><i class="fa fa-angle-double-right"></i> Quy chế hoạt động</a>
                            </li>
                            <li>
                                <a href="/chinh-sach-bao-mat"><i class="fa fa-angle-double-right"></i> Chính sách bảo mật</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                <ul class="list-unstyled clear-margins">
                    <li class="widget-container widget_nav_menu">
                        <h1 class="title-widget">Góc điện ảnh</h1>
                        <ul>
                            <li>
                                <a href="/dien-anh"><i class="fa fa-angle-double-right"></i> Thể loại phim</a>
                            </li>
                            <li>
                                <a href="/binh-luan-phim"><i class="fa fa-angle-double-right"></i> Bình luận phim</a>
                            </li>
                            <li>
                                <a href="/movie-blog"><i class="fa fa-angle-double-right"></i> Blog điện ảnh</a>
                            </li>
                            <li>
                                <a href="/phim-hay"><i class="fa fa-angle-double-right"></i> Phim hay tháng</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                <ul class="list-unstyled clear-margins">
                    <li class="widget-container widget_nav_menu">
                        <h1 class="title-widget">Hỗ trợ</h1>
                        <ul>
                            <li>
                                <a href="/gop-y"><i class="fa fa-angle-double-right"></i> Góp ý</a>
                            </li>
                            <li>
                                <a href="/sale-and-service"><i class="fa fa-angle-double-right"></i> Sale &amp; Services</a>
                            </li>
                            <li>
                                <a href="/rap-gia-ve"><i class="fa fa-angle-double-right"></i> Rạp / giá vé</a>
                            </li>
                            <li>
                                <a href="/tuyen-dung"><i class="fa fa-angle-double-right"></i> Tuyển dụng</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                <ul class="list-unstyled clear-margins">
                    <li class="widget-container widget_recent_news">
                        <h1 class="title-widget">Kết nối Galaxy cinema</h1>
                        <div class="social-icons"><ul class="nomargin">
                                <a href="https://facebook.com/galaxycine.vn" target="_blank"><i id="social" class="icon-facebook-app-logo social-fb"></i></a>
                                <a href="https://www.youtube.com/user/galaxymovies" target="_blank"><i id="social" class="icon-youtube-logo social-youtube"></i></a>
                                <a href="https://www.instagram.com/galaxycinema/" target="_blank"><i id="social" class="icon-instagram-logo social-inst"></i></a>
                            </ul>
                        </div>
                    </li>
                </ul>
                <div class="store">
                    <ul class="list-unstyled clear-margins">
                        <li class="widget-container widget_recent_news">
                            <h1 class="title-widget">Download app</h1>
                            <div class="social-icons">
                                <ul class="nomargin">
                                    <a href="https://itunes.apple.com/vn/app/galaxy-cinema/id593312549?l=vi&amp;mt=8" target="_blank"><i id="social" class="icon-apple-store social-store"></i></a>
                                    <a href="https://play.google.com/store/apps/details?id=com.galaxy.cinema&amp;hl=vi" target="_blank"><i id="social" class="icon-google-play social-store"></i></a>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>	

<script type="text/javascript" src="<c:url value="/resources/js/jquery.flexisel.js"/>"></script>
<script type="text/javascript">
    $(window).load(function () {

        $("#flexiselDemo1").flexisel({
            visibleItems: 6,
            animationSpeed: 1000,
            autoPlay: true,
            autoPlaySpeed: 3000,
            pauseOnHover: false,
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
                portrait: {
                    changePoint: 480,
                    visibleItems: 2
                },
                landscape: {
                    changePoint: 640,
                    visibleItems: 3
                },
                tablet: {
                    changePoint: 768,
                    visibleItems: 4
                }
            }
        });
    });
</script>
<script type="text/javascript">
    $(window).load(function () {

        $("#flexiselDemo2").flexisel({
            visibleItems: 4,
            animationSpeed: 1000,
            autoPlay: true,
            autoPlaySpeed: 3000,
            pauseOnHover: false,
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
                portrait: {
                    changePoint: 480,
                    visibleItems: 2
                },
                landscape: {
                    changePoint: 640,
                    visibleItems: 3
                },
                tablet: {
                    changePoint: 768,
                    visibleItems: 3
                }
            }
        });
    });
</script>

<!-- pop-up-box --> 
<link href="<c:url value="/resources/css/popuo-box.css"/>" rel="stylesheet" type="text/css" media="all" />
<script src="<c:url value="/resources/js/jquery.magnific-popup.js"/>" type="text/javascript"></script>
<script>
    $(document).ready(function () {
        $('.popup-with-zoom-anim').magnificPopup({
            type: 'inline',
            fixedContentPos: false,
            fixedBgPos: true,
            overflowY: 'auto',
            closeBtnInside: true,
            preloader: false,
            midClick: true,
            removalDelay: 300,
            mainClass: 'my-mfp-zoom-in'
        });
    });
</script>		

<!--//pop-up-box -->

<script type="text/javascript">
    $(window).load(function () {

        $("#flexiselDemo1").flexisel({
            visibleItems: 6,
            animationSpeed: 1000,
            autoPlay: true,
            autoPlaySpeed: 3000,
            pauseOnHover: false,
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
                portrait: {
                    changePoint: 480,
                    visibleItems: 2
                },
                landscape: {
                    changePoint: 640,
                    visibleItems: 3
                },
                tablet: {
                    changePoint: 768,
                    visibleItems: 3
                }
            }
        });
    });
</script>
<script type="text/javascript">
    $(window).load(function () {

        $("#flexiselDemo1").flexisel({
            visibleItems: 6,
            animationSpeed: 1000,
            autoPlay: true,
            autoPlaySpeed: 3000,
            pauseOnHover: false,
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
                portrait: {
                    changePoint: 480,
                    visibleItems: 1
                },
                landscape: {
                    changePoint: 640,
                    visibleItems: 2
                },
                tablet: {
                    changePoint: 768,
                    visibleItems: 3
                }
            }
        });
    });
</script>
