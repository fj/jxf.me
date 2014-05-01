// infinite scroll


jQuery.ajaxSetup({async:false});
jQuery(function() {
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url;
      url = $('#next_page_link:last-child').attr('href');
      //$(".pagination").remove();
      $(".pagination:not(:last-child)").text('');

      //if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
      if (url && ($(window).scrollTop() > $(document).height() - $(window).height() - 25)) {
        console.log("URL: " + url);
        // data = $.get(url, function( data ) {
        //     $( ".main" ).append( data );
        //   }

        //   );
        $(".pagination").text('');
        html = $.get(url).responseText;
        main = $('article', html);
        pagination = $('.pagination', html)
        //console.log(main);
        $('.main-blog:last-child').append(main, pagination);
      }
    });
    return $(window).scroll();
  }
});