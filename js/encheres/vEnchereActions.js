///////////////////////////////////////////////////////////////////////////////
// Ce fichier contient le code lié à l'interface usager du site Web. Le code
// concernant l'état et le comportement du site se trouve dans la classe `Encheres`.

import EncheresApp from "./Encheres.js";

const btnAjouterFavoris = document.querySelector("#btnAjouterFavoris");
btnAjouterFavoris.addEventListener("click", (element) => {
  element.preventDefault();
  let appl = new EncheresApp();
  appl.toggleFavoris(element);
});
