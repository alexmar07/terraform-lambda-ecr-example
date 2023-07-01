import {API_ENDPOINT} from './config.js';

$(document).ready( function() {

    $.ajax({
        url: API_ENDPOINT
    })
    .done(function( data ) {
        $('h1').html(data.message).removeClass('placeholder');
    });
})
