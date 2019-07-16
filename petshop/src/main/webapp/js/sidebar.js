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

//subtitle start
var Str = "ambitious frontend web developer.";
var Arr = Str.split("");
var loopStart;
function myloop() {
  if (Arr.length > 0) {
    document.getElementById("subtitle").innerHTML += Arr.shift();
  } else {
    clearTimeout(loopStart);
  }
  loopStart = setTimeout("myloop()", 100);
}
myloop();

//slideanimation
function x() {
  var img = document.getElementsByClassName("slideanimation");

  for (var i = 0; i < img.length; i++) {
    var scrollPos = window.scrollY + window.innerHeight - img[i].height / 2;
    var isHalfShown = scrollPos > img[i].offsetTop;
    if (isHalfShown) {
      img[i].classList.add("show");
    }
  }
}
document.addEventListener("scroll", x);
