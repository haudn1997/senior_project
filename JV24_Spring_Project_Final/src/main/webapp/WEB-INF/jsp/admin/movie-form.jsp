

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
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Dashboard</a>
            </div>
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
                    <h1>ADD NEW MOVIE </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-xs-12">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12">
                            <f:form method="post" action="${pageContext.request.getContextPath()}/admin/upload/${movie.id}" modelAttribute="uploadForm" enctype="multipart/form-data">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6 col-xs-6">
                                            <div class="row">
                                                <div class="col-sm-3 col-xs-4">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default btn-choose" type="button">Choose</button>
                                                    </span>
                                                </div>
                                                <div class="col-sm-6 col-xs-4">
                                                    <input type="text" class="form-control" placeholder='Choose a file...' style="width:100%">
                                                </div>
                                                <div class="col-sm-3 col-xs-4">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-warning btn-reset" type="button">Reset</button>
                                                    </span>
                                                </div>
                                            </div>  
                                        </div>
                                        <div class="col-sm-6 col-xs-6" style="padding-right: 220px;">
                                            <button type="submit" class="btn btn-primary pull-right" >Update</button>
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
                            <label class="col-sm-2 col-xs-4 control-lable">Name:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="name" type="text" placeholder="Enter a name movie" class="form-control" value="${movie.name}" required="" />
                            </div>
                        </div>
                        <c:if test="${imagesupload != null && imagesupload !=''}">
                            <div class="form-group">
                                <label  class="col-sm-2 col-xs-4  control-lable">Images:<span style="color: red">(*)</span></label>
                                <div class="col-xs-8 col-sm-8">
                                    <input name="image" type="text" placeholder="update image before" class="form-control" required="" value="${imagesupload}" />
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${imagesupload == null}">
                            <div class="form-group">
                                <label  class="col-sm-2 col-xs-4  control-lable">Images:<span style="color: red">(*)</span></label>
                                <div class="col-xs-8 col-sm-8">
                                    <input name="image" type="text" placeholder="update image before" class="form-control" required="" value="${movie.image}" />
                                </div>
                            </div>
                        </c:if>
                        <div class="form-group">
                            <label  class="col-sm-2 col-xs-4  control-lable">Actor:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="actor" type="text" placeholder="Enter author" class="form-control"  value="${movie.actor}" required=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 col-xs-2  control-lable">Director:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="director" type="text"  class="form-control" value="${movie.director}" required=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 col-xs-4 col-md-4 control-lable">Des:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="description" type="text"  class="form-control" value="${movie.description}" required="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 col-xs-4  control-lable">Link:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="link" type="text"  class="form-control"  value="${movie.link}" required=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 col-xs-4  control-lable">DateStart:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="dateStartShowing" type="date" placeholder="yyyy-MM-dd"  class="form-control" required="" value="${movie.dateStartShowing}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 col-xs-4  control-lable">Time:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-8">
                                <input name="time" type="text" placeholder="hh:mm:ss "  class="form-control"  required=""  value="${movie.time}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 col-xs-4  control-lable">Category:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-5">
                                <select name="categoryMovie.id" class="form-control">
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
                            <label  class="col-sm-2 col-xs-4  control-lable">Country:<span style="color: red">(*)</span></label>
                            <div class="col-xs-8 col-sm-5">
                                <select name="country.id" class="form-control">
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
                            <input type="submit" class="btn btn-danger" value="Add New"/>
                        </div>
                    </f:form>
                </div>
            </div>
        </div>
    </div>

</div>