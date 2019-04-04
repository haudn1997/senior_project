

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link type="text/css" rel="stylesheet" href="${pageContext.request.getContextPath()}/webjars/bootstrap/3.3.7/css/bootstrap.min.css"/>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

<style>
    .form-control{
        width: 100%;
        height: 30px;
        padding-left: 10px;
    }
    .control-lable{
        width: 110px;
    }
    #imageUpdate{
        border: silver 2px dotted;
        min-width: 200px;
        min-height: 200px;
        margin-bottom: 30px;
    }
    .affix{
        top: 0;
        width: 100%;
        z-index: 9999 !important;

    }
</style>
<script>
    function bs_input_file() {
        $(".input-file").before(
                function () {
                    if (!$(this).prev().hasClass('input-ghost')) {
                        var element = $("<input type='file' class='input-ghost' style='visibility:hidden; height:0'>");
                        element.attr("name", $(this).attr("name"));
                        element.change(function () {
                            element.next(element).find('input').val((element.val()).split('\\').pop());
                        });
                        $(this).find("button.btn-choose").click(function () {
                            element.click();
                        });
                        $(this).find("button.btn-reset").click(function () {
                            element.val(null);
                            $(this).parents(".input-file").find('input').val('');
                        });
                        $(this).find('input').css("cursor", "pointer");
                        $(this).find('input').mousedown(function () {
                            $(this).parents('.input-file').prev().click();
                            return false;
                        });
                        return element;
                    }
                }
        );
    }
    $(function () {
        bs_input_file();
    });
</script>

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
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12" style="text-align: center ; padding-bottom: 50px" >
                    <h1 style="color: #23527c">THÊM VÀ CẬP NHẬT PHIM</h1>
                </div>
            </div>
            <div class="row" style="margin-left: 150px;">
                <div class="col-md-12 col-xs-12">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12">
                            <f:form method="post" action="${pageContext.request.getContextPath()}/admin/upload/${movie.id}" modelAttribute="uploadForm" enctype="multipart/form-data">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6 col-xs-6">
                                            <div class="form-group">
                                                <div class="input-group input-file" name="fileUpload">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-warning btn-choose" type="button">Chọn</button>
                                                    </span>
                                                    <input type="text" class="form-control" placeholder='Choose a file...' style="height: 40px;">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-warning btn-reset" type="button">Hủy</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-xs-6" style="padding-right: 280px;">
                                            <button type="submit" class="btn btn-primary pull-right" >Cập Nhật</button>
                                        </div>
                                    </div>

                                </div>
                            </f:form>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 col-xs-12" style="margin-top: 50px;">
                    <f:form action="${pageContext.request.getContextPath()}/admin/${action}" method="post" modelAttribute="movies" class="form-horizontal">
                        <c:if test="${action== 'update-movie'}">
                            <input type="text" hidden name="id" value="${movie.id}"/>
                        </c:if>
                        <div class="form-group">
                            <label class="col-sm-3 col-xs-4 control-lable">Tên phim:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="name" type="text" placeholder="Nhập tên phim" class="form-control" value="${movie.name}" required="" />
                            </div>
                        </div>
                        <c:if test="${imagesupload != null && imagesupload !=''}">
                            <div class="form-group">
                                <label  class="col-sm-3 col-xs-4  control-lable">Hình ảnh:<span style="color: red">(*)</span></label>
                                <div class="col-xs-8 col-sm-8">
                                    <input name="image" type="text" placeholder="Nhập hình ảnh" class="form-control" required="" value="${imagesupload}" />
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${imagesupload == null}">
                            <div class="form-group">
                                <label  class="col-sm-3 col-xs-4  control-lable">Hình ảnh:<span style="color: red">(*)</span></label>
                                <div class="col-xs-8 col-sm-8">
                                    <input name="image" type="text" placeholder="Nhập hình ảnh" class="form-control" required="" value="${movie.image}" />
                                </div>
                            </div>
                        </c:if>
                        <div class="form-group">
                            <label  class="col-sm-3 col-xs-4  control-lable">Diễn viên:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="actor" type="text" placeholder="Nhập tên diễn viên" class="form-control"  value="${movie.actor}" required=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 col-xs-2  control-lable">Đạo diễn:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="director" type="text" placeholder="Nhập tên đạo diễn" class="form-control" value="${movie.director}" required=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 col-xs-4 col-md-4 control-lable">Mô tả:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="description" type="text" placeholder="Nhập mô tả" class="form-control" value="${movie.description}" required="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 col-xs-4  control-lable">Link:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="link" type="text" placeholder="Link của trailer" class="form-control"  value="${movie.link}" required=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 col-xs-4  control-lable">Ngày bắt đầu:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="dateStartShowing" type="date" placeholder="yyyy-MM-dd"  class="form-control" required="" value="${movie.dateStartShowing}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 col-xs-4  control-lable">Thời lượng phim:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="time" type="text" placeholder="hh:mm:ss "  class="form-control"  required=""  value="${movie.time}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 col-xs-4  control-lable">Loại phim:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-5">
                                <select name="categoryMovie.id" class="form-control">
                                    <option>Chọn loại phim</option>
                                    <c:forEach items="${lstCategoryMovie}" var="c">
                                        <c:if test="${movie.categoryMovie.id == c.id}">
                                            <option value="${c.id}" selected=""> ${c.name} </option>
                                        </c:if>
                                        <c:if test="${movie.categoryMovie.id != c.id}">                                           
                                            <option value="${c.id}"> ${c.name} </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 col-xs-4  control-lable">Quốc gia:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-5">
                                <select name="country.id" class="form-control">
                                    <option>Chọn quốc gia</option>
                                    <c:forEach items="${lstCountryMovie}" var="c">
                                        <c:if test="${movie.country.id == c.id}">
                                            <option value="${c.id}" selected="" > ${c.name} </option>
                                        </c:if>
                                        <c:if test="${movie.country.id != c.id}">
                                            <option value="${c.id}" > ${c.name} </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group" style="text-align: center; margin-top: 40px">
                            <input type="submit" class="btn btn-danger" value="Xong"/>
                        </div>
                    </f:form>
                </div>
            </div>
        </div>
    </div>

</div>