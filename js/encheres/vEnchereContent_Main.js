///////////////////////////////////////////////////////////////////////////////
// Ce fichier contient le code lié à l'interface usager du site Web. Le code
// concernant l'état et le comportement du site se trouve dans la classe `App`.

import EncheresApp from "./Encheres.js";

const mainEL = document.querySelector("main");
const resultsEL = document.querySelector("#lblResults");
const countEl = document.querySelector("#count");

const app = new EncheresApp(mainEL, resultsEL, countEl);

//get param page on url
const urlParams = new URLSearchParams(window.location.search);

//fetch et afficher les items
app.fetchItems(0);

const btnSearch = document.querySelector("#frmRechercherButton");
const searchInput = document.querySelector("#frmRechercherText");

btnSearch.addEventListener("click", (element) => {
  element.preventDefault();
  app.searchString = searchInput.value;
  app.filterAndDisplay();
});
app.searchString = searchInput.value;

const frmDropDownFavoris = document.querySelector("#frmDropDownFavoris");
frmDropDownFavoris.addEventListener("change", (element) => {
  element.preventDefault();
  app.favorisType = frmDropDownFavoris.value;
  app.filterAndDisplay();
});
app.favorisType = frmDropDownFavoris.value;

const frmDropDownCategories = document.querySelector("#frmDropDownCategories");
frmDropDownCategories.addEventListener("change", (element) => {
  element.preventDefault();
  app.categorieType = frmDropDownCategories.value;
  app.filterAndDisplay();
});
app.categorieType = frmDropDownCategories.value;

const frmDropDownCertificats = document.querySelector(
  "#frmDropDownCertificats"
);
frmDropDownCertificats.addEventListener("change", (element) => {
  element.preventDefault();
  app.certificatType = frmDropDownCertificats.value;
  app.filterAndDisplay();
});
app.certificatType = frmDropDownCertificats.value;

const frmDropDownStatus = document.querySelector(
  "#frmDropDownStatus"
);
frmDropDownStatus.addEventListener("change", (element) => {
  element.preventDefault();
  app.statusType = frmDropDownStatus.value;
  app.filterAndDisplay();
});
app.statusType = frmDropDownStatus.value;




const aBtnsFavoris = document.querySelectorAll("#btnAjouterFavoris");
aBtnsFavoris.forEach((btn) => {
  btn.addEventListener("click", (element) => {
    element.preventDefault();
    app.toggleFavoris(element);
  });
});



// const btnAjouterFavoris = document.querySelector("#btnAjouterFavoris");
// if (btnAjouterFavoris) {
//   btnAjouterFavoris.addEventListener("click", (element) => {
//     element.preventDefault();
//     let appl = new EncheresApp();
//     appl.toggleFavoris(element);
//   });
// }

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
// action pour afficher en grid ou liste
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
document.getElementById("btnTab1").addEventListener("click", event => openTab(event, 'tab1'));
document.getElementById("btnTab2").addEventListener("click", event => openTab(event, 'tab2'));
document.getElementById("btnTab3").addEventListener("click", event => openTab(event, 'tab3'));




// Ouverture de l'onglet dans le aside
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
