const pre = document.querySelector("pre");

document.addEventListener("mousemove", (e) => {
  rotateElement(e, pre);
});

/*rotates lil box to follow mouse cursor*/
function rotateElement(event, element) {
  // get mouse position
  const x = event.clientX;
  const y = event.clientY;
  // console.log(x, y)

  // find the middle
  const middleX = window.innerWidth / 2;
  const middleY = window.innerHeight / 2;
  // console.log(middleX, middleY)

  // get offset from middle as a percentage
  // and tone it down a little
  const offsetX = x/20-10;
  const offsetY = y/8-65;
  // console.log(offsetX, offsetY);

  // set rotation
  element.style.setProperty("--rotateX", offsetX + "deg");
  element.style.setProperty("--rotateY", -1 * offsetY + "deg");
}

/*imports another HTML script*/
function includeHTML() {
  var z, i, elmnt, file, xhttp;
  /* Loop through a collection of all HTML elements: */
  z = document.getElementsByTagName("*");
  for (i = 0; i < z.length; i++) {
  elmnt = z[i];
  /*search for elements with a certain atrribute:*/
  file = elmnt.getAttribute("w3-include-html");
  if (file) {
      /* Make an HTTP request using the attribute value as the file name: */
      xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
      if (this.readyState == 4) {
          if (this.status == 200) {elmnt.innerHTML = this.responseText;}
          if (this.status == 404) {elmnt.innerHTML = "Page not found.";}
          /* Remove the attribute, and call this function once more: */
          elmnt.removeAttribute("w3-include-html");
          includeHTML();
      }
      }
      xhttp.open("GET", file, true);
      xhttp.send();
      /* Exit the function: */
      return;
  }
  }
}