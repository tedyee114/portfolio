class ChangingTitle {
  constructor(x = null) {
    this.node = x;
    this.letterfy(this.node.querySelector('h1'));
  }

  letterfy(node) {
    let text = node.innerText;
    node.innerText = '';
    node.classList.add('current');
    for (let i = 0; i < text.length; i++) {
      let span = document.createElement('span');
      span.innerText = text[i];
      span.classList.add('letter', 'in');
      span.style.animationDelay = `${i * 0.1}s`;
      node.appendChild(span);
    }
  }

  changeText(newText) {
    let oldTitle = this.node.querySelector('.current');
    let i = 0;
    for (let letter of oldTitle.children) {
      letter.style.animationDelay = `${i++ * 0.1}s`;
      letter.classList.remove('in');
      letter.classList.add('out');
    }
    oldTitle.classList.remove('current');

    let newTitle = document.createElement('h1');
    newTitle.classList.add('current');
    for (let i = 0; i < newText.length; i++) {
      let span = document.createElement('span');
      span.innerText = newText[i];
      span.classList.add('letter', 'in');
      span.style.animationDelay = `${i * 0.1 + 0.5}s`;
      newTitle.appendChild(span);
    }

    this.node.appendChild(newTitle);
    setTimeout(() => {
      oldTitle.remove();
    }, 2000);
  }
}

let ct = new ChangingTitle(document.querySelector('.changing-title'));
const texts = ['Hello', 'Aloha', 'Hola', 'Bonjour'];
let count = 0;
setInterval(() => {
  ct.changeText(texts[++count % texts.length]);
}, 2000);
