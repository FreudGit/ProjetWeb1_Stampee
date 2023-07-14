export default class EncheresApp {
  #data;
  #dataItems;
  #displayTarget;
  #resultsEL;
  #countEL;
  searchString;
  #originalData;
  favorisType;

  /**
   *
   * @param {Array} data - Jeu de données à afficher.
   * @param {HTMLElement} displayTarget - Élément dans lequel afficher le jeu de données
   * @param {HTMLElement} resultsEL - Élément dans lequel afficher les informations de pagination
   * @param {HTMLElement} countEL - Élément dans lequel afficher le nombre total de résultats
   */
  constructor(displayTarget, resultsEL, countEL) {
    this.#displayTarget = displayTarget;
    // this.#currentpage = 1;
    this.#resultsEL = resultsEL;
    this.#countEL = countEL;
    this.searchString = "";
  }

  /**
   * Filtre le titre des items selon un string.
   * @param {string} searchString - Chaîne de caractères à rechercher.
   * @param {Array} items - Tableau contenant les objects à afficher.
   * @returns {Array} - Tableau contenant les objects à afficher.
   */
  filterItems(searchString = this.searchString, items = this.#dataItems) {
    console.log("dataitems", this.#dataItems);
    console.log("bosbo");
    searchString = "";
    console.log(searchString);

    //filter array items. Item.DateFin should indlude searchString
    const filteredItems = items.filter((item) => {
      if (searchString === "") return true;
      if (item.TimbreNom === null) return false;
      const itemDateFin = item.TimbreNom;
      const lc = itemDateFin.toLowerCase();
      const filter = searchString.toLowerCase();
      return lc.includes(filter);
    });

    console.log("filter", filteredItems);
    return filteredItems;
  }

  filterAndDisplay(searchString = this.searchString) {
    this.searchString = searchString;
    this.#dataItems = this.#originalData;
    // console.log("originaldatas", this.#originalData);
    // console.log("dataitems", this.#dataItems);
    // console.log("this.favorisType", this.favorisType);

    let filteredItems = this.filterBySearch();
    filteredItems=this.filterByFavoris(this.favorisType, filteredItems);

    this.displayItems(filteredItems);
    this.displayResults();
  }

  displayItems(items = this.#dataItems) {
    const elementsCartes = this.#displayTarget.querySelectorAll(".carte");
    for (const elementCarte of elementsCartes) {
      elementCarte.classList.add("hidden");
    }

    for (const item of items) {
      const carteItem = document.getElementById("Enchere" + item.ID);
      console.log("carteItem", carteItem);
      carteItem.classList.remove("hidden");
    }
  }

  updateUrlParam(paramName, paramValue) {
    var url = new URL(window.location.href);
    url.searchParams.set(paramName, paramValue);
    window.history.pushState({ path: url.href }, "", url.href);
  }

  filterBySearch(searchString = this.searchString, items = this.#dataItems) {
    const url = new URL(window.location.href);
    this.updateUrlParam("search", searchString);
    console.log("searchString", searchString);
    //filter array items. Item.DateFin should indlude searchString
    const filteredItems = items.filter((item) => {
      if (searchString === "") return true;
      if (item.TimbreNom === null) return false;
      const itemDateFin = item.TimbreNom;
      const lc = itemDateFin.toLowerCase();
      const filter = searchString.toLowerCase();
      const bFound = lc.includes(filter);
      if (bFound) {
        console.log("itemFOund", item);
        const carteItem = document.getElementById("Enchere" + item.ID);
        console.log("carteItem", carteItem);
        carteItem.classList.add("hidden");
      }
      return bFound;
    });
    return filteredItems;
  }

  filterByFavoris(sType = this.favorisType, items = this.#dataItems) {
    this.updateUrlParam("favoris", sType);
    const filteredItems = items.filter((item) => {
      let favItem = "";
      if (sType === "FavorisLord") {
        favItem = item.bFavorisLord;
      } else if (sType === "FavorisUsager") {
        favItem = item.bFavoris;
      } else {
        favItem = 1;
      }

      if (favItem == 1) {
        console.log("itesmFOund", item);
        const carteItem = document.getElementById("Enchere" + item.ID);
        //console.log("carsteItem", carteItem);
        //carteItem.classList.add("hidden");
      }
      return favItem;
    });
    return filteredItems;
  }

  /**
   * Récupère les données de l'API et les affiche
   */
  async fetchItems(page = 1) {
    fetch("recupererEncheresFromJS")
      .then((reponse) => {
        if (!reponse.ok) throw { message: "Problème technique sur le serveur" };
        return reponse.json();
      })
      .then((liste) => {
        this.#originalData = liste;
        console.log(liste);
        this.#data = liste;
        this.#dataItems = liste;
        const urlCourant = new URL(window.location.href);
        window.history.replaceState(null, null, urlCourant);
        document.body.style.cursor = "auto";
        console.log("fin fetch");
      })
      .catch((e) => {
        console.log("Erreur: " + e.message);
      });
  }

  /**
   * Affiche le nombre de résultats et le numéro de page
   */
  displayResults() {
    //this.#resultsEL.textContent =
    //  "Page " + this.#currentpage + " sur " + this.#data.pagination.total_pages;
    //this.#countEL.textContent =
    //  "Nombre de résultats: " + this.#data.pagination.total;
  }
}
