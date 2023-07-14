///////////////////////////////////////////////////////////////////////////////
// Ce fichier contient le code lié à l'interface usager du site Web. Le code
// concernant l'état et le comportement du site se trouve dans la classe `App`.

import EncheresApp from "./Encheres.js";
const mainEL = document.querySelector("main");
const resultsEL = document.querySelector("#results");
const countEl = document.querySelector("#count");

const app = new EncheresApp(mainEL, resultsEL, countEl);

//get param page on url
const urlParams = new URLSearchParams(window.location.search);
let page = parseInt(urlParams.get("page"));

//check if page is a number//
if (isNaN(page)) page = 1;
//app.testFetch();
//fetch et afficher les items
app.fetchItems(page);

const btnSearch = document.querySelector("#frmRechercherButton");
const searchInput = document.querySelector("#frmRechercherText");

btnSearch.addEventListener("click", (element) => {
  element.preventDefault();
  app.searchString = searchInput.value;
  app.filterAndDisplay();
});

const frmDropDownFavoris = document.querySelector("#frmDropDownFavoris");
frmDropDownFavoris.addEventListener("change", (element) => {
  element.preventDefault();
  app.favorisType = frmDropDownFavoris.value;
  app.filterAndDisplay();
});
