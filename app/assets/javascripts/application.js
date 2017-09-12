// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sass/assets/javascripts/bootstrap-sprockets
//= require_tree .


$(document).ready(function() {
    var url = window.location.href;
    $('ul.nav > li').removeClass('active');

    if (url.indexOf('/sales') !== -1) {
        $('.sales').addClass('active');
    } else {
        $('.period').addClass('active');
    }

    $('.period-button').daterangepicker({
            locale: {
                format: 'YYYY-MM-DD'
            },
            startDate: '2012-06-01',
            endDate: '2012-07-31'
        },
        function(start, end, label) {
            $.ajax({
                type: "GET",
                url: "/by-dates.json",
                data: "report_start=" + start.format('YYYY-MM-DD') + "&report_end=" + end.format('YYYY-MM-DD'),
                success: function(msg) {
                    $('.modal-title').text("Profit for " + start.format('DD.MM.YYYY') + ' - ' + end.format('DD.MM.YYYY'));
                    $('.show-profit').text("$" + msg.profit);
                    $('#myModal').modal('show');
                }
            });
        }
    )

    $('.sales-button').on('click', function(e) {
        var filterValue = $('.form-control').val();
        $.ajax({
            type: "GET",
            url: "/by-month.json",
            data: "count_sales=" + filterValue,
            success: function(msg) {

                $('.modal-title').text("Profit by month (count sales - " + filterValue + ")");
                if (msg.response.length > 0 ) {
                    $('.table-body').children().remove()
                    $('.no-row').hide();
                    $('.table-responsive').show();

                    msg.response.forEach(function (el) {
                        var html = '<tr><td>' + el.year_month + '</td><td>' + el.profit + '</td></tr>>';
                        $('.table-body').append(html);
                    });
                } else {
                    $('.no-row').show();
                    $('.table-responsive').hide();
                }

                $('#myModal').modal('show');
            }
        });
    });
});
