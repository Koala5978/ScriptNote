function AutoClickBounsPointButton() {
  setInterval(() => {
    let buttons = document.getElementsByTagName('button');
    for (let i = 0; i < buttons.length; i++) {
        let button = buttons[i];
    	if (button.getAttribute('aria-label') == '領取額外獎勵') {
    	    button.click();
        break;
      }
    }
  }, 1000)
}
