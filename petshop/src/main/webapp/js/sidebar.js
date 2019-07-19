$(document).ready(function() {
  //sidebar start
  $(".sidebtn").click(function() {
    $(".sidebar").toggleClass("active");
    $(".sidebtn").toggleClass("toggle");
  });
  //sidebar end
  //smooth scroll start
  $("a").on("click", function(event) {
    if (this.hash !== "") {
      event.preventDefault();
      var hash = this.hash;
      $("html, body").animate(
        {
          scrollTop: $(hash).offset().top
        },
        800,
        function() {
          window.location.hash = hash;
        }
      );
    } // End if
  });
  //smooth scroll end
});
