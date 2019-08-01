function init() {
  window.colours = ["#B3E8FF", "#B3FFC0", "#FFFFA5"];
  window.notes = [];

  for (var i = 0; i < 3; i++) {
    newNote();
  }

  // Note dragged over the page
  document.body.addEventListener(
    "dragover",
    function(ev) {
      ev.preventDefault();
      return false;
    },
    false
  );

  // Note dropped on the page
  document.body.addEventListener(
    "drop",
    function(ev) {
      var data = ev.dataTransfer.getData("text/plain").split(",");
      notes[data[0]].style.left = ev.clientX + parseInt(data[1], 10) + "px";
      notes[data[0]].style.top = ev.clientY + parseInt(data[2], 10) + "px";
      ev.preventDefault();
      return false;
    },
    false
  );
  
  // Add button
  document.getElementById('tool-add').addEventListener(
    "click",
    function(ev) {
      newNote();
    },
    false
  );
}

function newNote(n) {
  var n = notes.length;
  
  // Generate the outer div
  var div = document.createElement("div");
  div.setAttribute("class", "note");
  div.setAttribute("draggable", "true");
  div.setAttribute("data-n", n);
  div.style.background = colours[n % 3];
  div.style.left = Math.random() * (window.innerWidth - 250) + "px";
  div.style.top = Math.random() * (window.innerHeight - 250) + "px";

  // Generate the note title
  var h1 = document.createElement("h1");

  // Generate the handle
  var handle = document.createElement("i");
  handle.setAttribute("class", "fa fa-arrows");

  var title = document.createElement("span");
  title.textContent = "Note #" + (n + 1);
  title.setAttribute("contenteditable", "true");
  title.setAttribute("spellcheck", "false");

  // Generate the note text
  var p = document.createElement("p");
  p.textContent =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus commodo a nisl vitae dapibus. Praesent et dignissim odio. Etiam cursus lectus enim, ac pulvinar enim semper in";
  p.setAttribute("contenteditable", "true");
  p.setAttribute("spellcheck", "false");

  h1.appendChild(handle);
  h1.appendChild(title);
  div.appendChild(h1);
  div.appendChild(p);

  document.body.appendChild(div);

  // Set the note to the foreground if clicked
  div.addEventListener(
    "click",
    function(ev) {
      for (var i = 0; i < notes.length; i++) {
        notes[i].style.zIndex = 1;
        if (i === parseInt(this.dataset.n)) {
          notes[i].style.zIndex = 2;
        }
      }
    },
    false
  );

  // Note dragged
  div.addEventListener(
    "dragstart",
    function(ev) {
      var style = window.getComputedStyle(ev.target, null);
      ev.dataTransfer.setData(
        "text/plain",
        this.dataset.n +
          "," +
          (parseInt(style.getPropertyValue("left"), 10) - ev.clientX) +
          "," +
          (parseInt(style.getPropertyValue("top"), 10) - ev.clientY)
      );
    },
    false
  );

  notes.push(div);
}


function saveNotes() {
  var titles = [], text = [], bg = [], top = [], left = [];

  for (var i = 0; i < notes.length; i++) {
    titles[i] = notes[i].childNodes[0].lastChild.innerHTML;
    text[i] = notes[i].childNodes[1].innerHTML;
    bg[i] = notes[i].style.background;
    top[i] = notes[i].style.top;
    left[i] = notes[i].style.left;
  }

  Cookies.set("titles", titles, { expires: 365 });
  Cookies.set("text", text, { expires: 365 });
  Cookies.set("bg", bg, { expires: 365 });
  Cookies.set("top", top, { expires: 365 });
  Cookies.set("left", left, { expires: 365 });
}

function resetCookies() {
  Cookies.remove("titles");
  Cookies.remove("text");
  Cookies.remove("bg");
  Cookies.remove("top");
  Cookies.remove("left");
}

init();
// saveNotes();
