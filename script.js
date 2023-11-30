const textElement = document.getElementById('text');
const cursorElement = document.getElementById('cursor');

const text = "It's dangerous to go alone";
// update to include line breaks, array maybe? 
// const text = "Wanna know how long it takes to get over disappointment? As long as you decide it takes.";
const cursorBlinksBeforeStart = 2;

let cursorCharacter = '_';
let cursorCount = 0;
let index = 0;
let blinkSpeed = 50; // Typing speed in milliseconds

var typewriter = function typewriter() {
    if (cursorCount <= cursorBlinksBeforeStart + 1) {
        cursorCount % 2 == 0 ? textElement.innerHTML = cursorCharacter : textElement.innerHTML = "";
        cursorCount++;
        setTimeout(typewriter, blinkSpeed); 
    } else if (index < text.length) {
        textElement.innerHTML = textElement.innerHTML.replace(cursorCharacter, '');
        textElement.innerHTML += text.charAt(index) + cursorCharacter;
        index++;
        setTimeout(typewriter, blinkSpeed);
    } else {
        // cursorElement.style.display = 'none'; // Hide cursor at the end
        textElement.innerHTML = textElement.innerHTML.replace(cursorCharacter, '');
    }
}

typewriter();
