
function showingCinema() {
    document.getElementById("tab_default_1").style.display = "block";
    document.getElementById("tab_default_2").style.display = "none";
    document.getElementById("show").style.color = "orange";
    document.getElementById("show1").style.color = "#a0a3a7";
}

function showCinema() {
    document.getElementById("tab_default_1").style.display = "none";
    document.getElementById("tab_default_2").style.display = "block";
    document.getElementById("show").style.color = "#a0a3a7";
    document.getElementById("show1").style.color = "orange";
}



//$('#filmId').click(function () {
//    $.ajax({
//        type: "GET",
//        url: "${pageContext.request.getContextPath()}/ajax/"
//    });
//});
