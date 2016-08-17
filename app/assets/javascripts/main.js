/**
 * Created by yamon on 8/16/16.
 */
$(document).ready(function(){
    $('body').on('click','.sort-order', function(event){
        event.preventDefault();
        var dataSort = $(this).attr('data-sort');
        var dataOrder = $(this).attr('data-order');

        $("#data-sort").val(dataSort);
        $("#data-order").val(dataOrder);
        $("form#frmSearch").submit();
    });
});


function add_friend(id,url) {
    $.ajax({
        type: "POST",
        url: url,
        data: {userId: id},
        success: function(result) {

        }
    });
}

function un_friend(id,url) {
    $.ajax({
        type: "POST",
        url: url,
        data: {userId: id},
        success: function(result) {

        }
    });
}

function un_request(id,url) {
    $.ajax({
        type: "POST",
        url: url,
        data: {userId: id},
        success: function(result) {

        }
    });
}

function add_favorite(id,url) {
    $.ajax({
        type: "POST",
        url: url,
        data: {userId: id},
        success: function(result) {

        }
    });
}

function un_favorite(id,url) {
    $.ajax({
        type: "POST",
        url: url,
        data: {userId: id},
        success: function(result) {

        }
    });
}

function accept_friend(id,url) {

    $.ajax({
        type: "POST",
        url: url,
        data: {userId: id},
        success: function(result) {

        }
    });
}

//deny request
function deny_request(id,url) {
    $.ajax({
        type: "POST",
        url: url,
        data: {userId: id},
        success: function(result) {

        }
    });
}


//sort
function sort_by(sel,url){
    window.location.href = url+"?sort_by="+sel.value
}



