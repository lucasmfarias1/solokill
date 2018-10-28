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
//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  });

  $(window).scroll(function() {
    if ($(window).data('ajaxready') == false) return;

    if ($(window).scrollTop() + $(window).height() == $(document).height()) {
      $(window).data('ajaxready', false);
      var more_posts_url = $("#load_more_link").attr('href');

      if (more_posts_url) {
        $("#load_more_link").html('Loading...');
        $.getScript(more_posts_url);
      }

      $(window).data('ajaxready', true);
    }
  });
});
