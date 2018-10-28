var scrollTimer, lastScrollFireTime = 0;

$(window).on('scroll', function() {

    var minScrollTime = 100;
    var now = new Date().getTime();

    function processScroll() {
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
    }

    if (!scrollTimer) {
        if (now - lastScrollFireTime > (3 * minScrollTime)) {
            processScroll();   // fire immediately on first scroll
            lastScrollFireTime = now;
        }
        scrollTimer = setTimeout(function() {
            scrollTimer = null;
            lastScrollFireTime = new Date().getTime();
            processScroll();
        }, minScrollTime);
    }
});

// $(window).scroll(function() {
//   if ($(window).data('ajaxready') == false) return;
//
//   if ($(window).scrollTop() + $(window).height() == $(document).height()) {
//     $(window).data('ajaxready', false);
//     var more_posts_url = $("#load_more_link").attr('href');
//
//     if (more_posts_url) {
//       $("#load_more_link").html('Loading...');
//       $.getScript(more_posts_url);
//     }
//
//     $(window).data('ajaxready', true);
//   }
// });
