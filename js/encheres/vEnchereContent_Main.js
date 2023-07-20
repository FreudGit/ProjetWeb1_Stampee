///////////////////////////////////////////////////////////////////////////////
// Ce fichier contient le code lié à l'interface usager du site Web. Le code (App)
// concernant l'état et le comportement du site se trouve dans la classe `Encheres`.

import EncheresApp from "./Encheres.js";

const mainEL = document.querySelector("main");
const resultsEL = document.querySelector("#lblResults");
const countEl = document.querySelector("#count");

const app = new EncheresApp(mainEL, resultsEL, countEl);

//fetch et afficher les items
app.fetchItems(0);

//////////////////////////////////////////////////////////////////////////////////////////////
// Gestion sed items de filtres

const btnSearch = document.querySelector("#frmRechercherButton");
const searchInput = document.querySelector("#frmRechercherText");

btnSearch.addEventListener("click", (element) => {
  element.preventDefault();
  app.searchString = searchInput.value;
  app.filterAndDisplay();
});

getParamAndSetValue(searchInput, "search");
app.searchString = searchInput.value;

const frmDropDownFavoris = document.querySelector("#frmDropDownFavoris");
frmDropDownFavoris.addEventListener("change", (element) => {
  element.preventDefault();
  app.favorisType = frmDropDownFavoris.value;
  app.filterAndDisplay();
});
getParamAndSetValue(frmDropDownFavoris, "favoris");
app.favorisType = frmDropDownFavoris.value;

const frmDropDownCategories = document.querySelector("#frmDropDownCategories");
frmDropDownCategories.addEventListener("change", (element) => {
  element.preventDefault();
  app.categorieType = frmDropDownCategories.value;
  app.filterAndDisplay();
});
getParamAndSetValue(frmDropDownCategories, "categorie");
app.categorieType = frmDropDownCategories.value;

const frmDropDownCertificats = document.querySelector(
  "#frmDropDownCertificats"
);
frmDropDownCertificats.addEventListener("change", (element) => {
  element.preventDefault();
  app.certificatType = frmDropDownCertificats.value;
  app.filterAndDisplay();
});
getParamAndSetValue(frmDropDownCertificats, "certificat");
app.certificatType = frmDropDownCertificats.value;

const frmDropDownStatus = document.querySelector("#frmDropDownStatus");
frmDropDownStatus.addEventListener("change", (element) => {
  element.preventDefault();
  app.statusType = frmDropDownStatus.value;
  app.filterAndDisplay();
});
getParamAndSetValue(frmDropDownStatus, "status");
app.statusType = frmDropDownStatus.value;

const aBtnsFavoris = document.querySelectorAll("#btnAjouterFavoris");
aBtnsFavoris.forEach((btn) => {
  btn.addEventListener("click", (element) => {
    element.preventDefault();
    app.toggleFavoris(element);
  });
});

/**
 * Recupère un paramètre dans l'url et le met dans un élément
 * @param {htmlelement} element
 * @param {string} param
 * @returns null si le paramètre n'existe pas ou la valeur du paramètre
 */
function getParamAndSetValue(element, param) {
  var url = new URL(window.location.href);
  var searchParams = new URLSearchParams(url.search);
  var myParam = searchParams.get(param);
  if (myParam != null) {
    element.value = myParam;
    return myParam;
  }
  return null;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// Gestion GRID ou LISTE

// gestion des boutons
const boutonGrille = document.querySelector("#btnGrille");
boutonGrille.onclick = function (event) {
  const parametre = false;
  actionGrid(event, parametre);
};

const boutonList = document.querySelector("#btnListe");
boutonList.onclick = function (event) {
  const parametre = true;
  actionGrid(event, parametre);
};
const grille = document.querySelector(".grille");
document.getElementById("tab1").style.display = "block";
document.querySelector(".tablinks").classList.add("active");

//////////////////////////////////////////////////////////////////////////////////////////////
// Fonctions pour afficher en grid ou liste

/**
 * action pour afficher en grid ou liste
 * @param {*} evt
 * @param {*} bGrid
 */
function actionGrid(evt, bGrid) {
  evt.preventDefault();
  console.log(evt.currentTarget);
  if (!bGrid) {
    boutonList.querySelector("i").classList.remove("gradient");
    grille.classList.remove("en-pile");
  } else {
    boutonGrille.querySelector("i").classList.remove("gradient");
    grille.classList.add("en-pile");
  }
  evt.currentTarget.classList.add("selected");
  evt.currentTarget.querySelector("i").classList.add("gradient");
}

/////////////////////////////////////////////////////////////////////////////////////////////
// gestion des onglets

// TODO: Programmer les options de search et de filtres des onglet 2 et 3
document
  .getElementById("btnTab1")
  .addEventListener("click", (event) => openTab(event, "tab1"));
document
  .getElementById("btnTab2")
  .addEventListener("click", (event) => openTab(event, "tab2"));
document
  .getElementById("btnTab3")
  .addEventListener("click", (event) => openTab(event, "tab3"));

/**
 * Ouverture d'un onglet
 * @param {event} evt
 * @param {*} tabName
 */
function openTab(evt, tabName) {
  evt.preventDefault();
  var i, tabcontent, tablinks;

  // Cacher tous les contenus des onglets
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Supprimer la classe "active" de tous les boutons d'onglet
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace("active", "");
  }

  // Afficher le contenu de l'onglet sélectionné et ajouter la classe "active" au bouton d'onglet correspondant
  document.getElementById(tabName).style.display = "block";
  evt.currentTarget.classList.add("active");
}
