/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

