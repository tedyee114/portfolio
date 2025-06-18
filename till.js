document.addEventListener('DOMContentLoaded', function() {
    // Mouse rotation for pre element
    const pre = document.querySelector("pre");
    if (pre) {
        document.addEventListener("mousemove", (e) => {
            rotateElement(e, pre);
        });
    }

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
        // get offset from middle as a percentage and tone it down a little
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
                        if (this.status == 200) {
                            elmnt.innerHTML = this.responseText;
                            // Initialize theme button after HTML is loaded
                            setTimeout(initializeThemeButton, 100);
                            // Initialize scroll effect for new header
                            setTimeout(initializeScrollEffect, 100);
                        }
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

    // Initialize scroll effect for header
    function initializeScrollEffect() {
        // Make sure jQuery is available before using it
        if (typeof $ !== 'undefined') {
            $(window).off('scroll.headerEffect'); // Remove any existing scroll handlers
            $(window).on('scroll.headerEffect', function() {
                const headerContainer = document.querySelector('.header-container');
                if (headerContainer) {
                    if($(window).scrollTop() > 70) {
                        headerContainer.classList.add("navbar_light");
                    } else {
                        headerContainer.classList.remove("navbar_light");
                    }
                }
            });
        } else {
            // Fallback to vanilla JavaScript if jQuery isn't loaded yet
            window.addEventListener('scroll', function() {
                const headerContainer = document.querySelector('.header-container');
                if (headerContainer) {
                    if(window.scrollY > 70) {
                        headerContainer.classList.add("navbar_light");
                    } else {
                        headerContainer.classList.remove("navbar_light");
                    }
                }
            });
        }
    }

    // Initialize theme
    document.documentElement.classList.add('theme1'); // Match the toggle button

    /*changes the theme colors*/
    const themes = ["theme1", "theme2"];
    let currentThemeIndex = 0;
    
    function initializeThemeButton() {
        const themeToggleButton = document.getElementById("themeToggle");
        console.log("Looking for theme button:", themeToggleButton); // Debug line
        if (themeToggleButton && !themeToggleButton.hasAttribute('data-initialized')) {
            console.log("Initializing theme button"); // Debug line
            themeToggleButton.setAttribute('data-initialized', 'true');
            themeToggleButton.addEventListener("click", () => {
                console.log("Theme button clicked!"); // Debug line
                // Remove all themes
                document.documentElement.classList.remove(...themes);
               
                // Apply the next theme
                currentThemeIndex = (currentThemeIndex + 1) % themes.length;
                document.documentElement.classList.add(themes[currentThemeIndex]);
                console.log("Applied theme:", themes[currentThemeIndex]); // Debug line
            });
        }
    }

    // Initialize theme button on initial load
    initializeThemeButton();

    // Changing Header
    class ChangingTitle {
        constructor(x=null) {
            this.node = x;
            if (this.node && this.node.querySelector('h1')) {
                this.letterfy(this.node.querySelector('h1'));
            }
        }
        
        letterfy(node) {
            let text = node.innerText;
            node.innerText = '';
            node.classList.add('current');
            for (let c in text) {
                let span = document.createElement('span');
                span.innerText = text[c];
                span.classList.add('letter', 'in');
                span.style.animationDelay = `${c * 0.1}s`;
                node.appendChild(span);
            }
        }
        
        changeText(newText) {
            let oldTitle = this.node.querySelector('.current');
            if (!oldTitle) return; // Safety check
            
            let i = 0;
            for (let letter of oldTitle.children) {
                letter.style.animationDelay = `${i++ * 0.2}s`;
                letter.classList.remove('in');
                letter.classList.add('out');
            }
            oldTitle.classList.remove('current');
            
            let newTitle = document.createElement('h1');
            newTitle.classList.add('current');
            for (let c in newText) {
                let span = document.createElement('span');
                span.innerText = newText[c];
                span.classList.add('letter', 'in');
                span.style.animationDelay = `${c * 0.1 + 0.5}s`;
                newTitle.appendChild(span);
            }
            this.node.appendChild(newTitle);
            setTimeout(this.removeNode(oldTitle), 2000);
        }
        
        removeNode(x) {
            return () => {
                if (x && x.parentNode) {
                    x.remove();
                }
            }
        }
    }

    // Only initialize ChangingTitle if the element exists
    const changingTitleElement = document.querySelector('.changing-title');
    if (changingTitleElement) {
        let ct = new ChangingTitle(changingTitleElement);
        const texts = ['Hola', 'Για σασ', 'こんにちは', 'Bonjour', 'Kia Ora', 'Hallo'];
        let count = 0;
        setInterval(()=> {
            ct.changeText(texts[++count % texts.length]);
        }, 2000);
    }

    // Call includeHTML if needed
    includeHTML();
});