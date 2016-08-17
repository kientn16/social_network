/**
 * Created by yamon on 8/16/16.
 */

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


