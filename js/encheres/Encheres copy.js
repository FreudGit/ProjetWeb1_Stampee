export default class EncheresApp {
  #data;
  #dataItems;
  #displayTarget;
  #resultsEL;
  #countEL;
  #searchString;
  #originalData;
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
    this.#searchString = "";
  }

  /**
   * Filtre le titre des items selon un string.
   * @param {string} searchString - Chaîne de caractères à rechercher.
   * @param {Array} items - Tableau contenant les objects à afficher.
   * @returns {Array} - Tableau contenant les objects à afficher.
   */
  filterItems(searchString = this.#searchString, items = this.#dataItems) {
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

  hideItemsBySearch(
    searchString = this.#searchString,
    items = this.#dataItems
  ) {
    console.log("dataitems", this.#dataItems);
    console.log("bosbo");
    searchString = "Timbre";
    console.log(searchString);
    //const cartesItems = userList.querySelectorAll(".carte");
    console.log("dataitems", this.#dataItems);

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

    console.log("filter", filteredItems);
    return filteredItems;
  }

  /**
   * Crée les objets html et les affiche
   * @param {Array} items - Tableau contenant les objects à afficher.
   */
  displayItems(items = this.#dataItems) {
    const sectionEL = document.createElement("section");
    for (const movie of items) {
      const movieArticleEl = this.createArticleEl(movie);
      sectionEL.appendChild(movieArticleEl);
    }

    this.#displayTarget.replaceChildren(sectionEL);
    sectionEL.classList.add("contentBox");
  }

  /**
   * Crée les objets html et les affiche
   * @param {Array} items - Tableau contenant les objects à afficher.
   */
  displayItemsOLD(items = this.#dataItems) {
    const sectionEL = document.createElement("section");
    for (const movie of items) {
      const movieArticleEl = this.createArticleEl(movie);
      sectionEL.appendChild(movieArticleEl);
    }

    this.#displayTarget.replaceChildren(sectionEL);
    sectionEL.classList.add("contentBox");
  }

  /**
   * Filtre les items et les affiche
   * @param {string} searchString - Chaîne de caractères à rechercher.
   */
  filterAndDisplay(searchString = this.#searchString) {
    this.#searchString = searchString;
    const filteredItems = this.filterItems(searchString);
    this.displayItems(filteredItems);
    this.displayResults();
  }

  /**
   * Récupère les données de l'API et les affiche
   */
  async fetchItems(page = 1) {
    //this.#currentpage = page;
    console.log("fetchItems");
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
        //this.#dataItems = liste.data;

        //this.filterAndDisplay();

        // Ajuster le param de page
        const urlCourant = new URL(window.location.href);
        //urlCourant.searchParams.set("page", this.#currentpage);
        window.history.replaceState(null, null, urlCourant);
        document.body.style.cursor = "auto";
        console.log("fin fetch");
      })
      .catch((e) => {
        console.log("Erreur: " + e.message);
      });

    //const data = sessionStorage.getItem("aEncheres");
    //const hey = sessionStorage.setItem("bobo", "bobjo");
    //console.log(sessionStorage.getItem("bobo"));

    // try {
    //   // const url =
    //   //   "https://api.artic.edu/api/v1/artworks?page=" +
    //   //   this.#currentpage +
    //   //   "&limit=10";
    //   // const res = await fetch(url);
    //   // const data = await res.json();

    //   //get data from session var Data
    //   //const session = $_SESSION['aEncheres'];
    //   //const session = sessionStorage.getItem("aEncheres");
    //   const data = sessionStorage.getItem("aEncheres");
    //   this.#data = JSON.parse(data);
    //   console.log(data);

    //   //this.#data = data;
    //   //this.#dataItems = data.data;

    //   this.filterAndDisplay();

    //   // Ajuster le param de page
    //   const urlCourant = new URL(window.location.href);
    //   //urlCourant.searchParams.set("page", this.#currentpage);
    //   window.history.replaceState(null, null, urlCourant);
    //   document.body.style.cursor = "auto";
    // } catch (error) {
    //   console.error(error);
    // }
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

  // /**
  //  * Crée un élément article pour un item
  //  * @param {Object} oItem - Objet contenant les données d'un item.
  //  * @returns {HTMLElement} - Élément article contenant les données d'un item.
  //  */
  // createArticleEl(oItem) {
  //   const articleEl = document.createElement("article");

  //   // Récupération de l'image https://api.artic.edu/docs/#iiif-image-api pour détails sur l'API
  //   if (oItem.image_id !== null) {
  //     const imgEl = document.createElement("img");
  //     const imgSource =
  //       "https://www.artic.edu/iiif/2/" +
  //       oItem.image_id +
  //       "/full/843,/0/default.jpg";
  //     imgEl.src = imgSource;
  //     imgEl.alt = "";
  //     articleEl.appendChild(imgEl);
  //   }

  //   if (oItem.title !== null) {
  //     const titreEl = document.createElement("h2");
  //     titreEl.textContent = oItem.title;
  //     articleEl.appendChild(titreEl);
  //   }

  //   if (oItem.dimensions !== null) {
  //     const dimensionsEl = document.createElement("p");
  //     dimensionsEl.textContent = "Dimension: " + oItem.dimensions;
  //     articleEl.appendChild(dimensionsEl);
  //   }

  //   if (oItem.artist_title !== null) {
  //     const artisteEl = document.createElement("p");
  //     artisteEl.textContent = "Artiste: " + oItem.artist_title;
  //     articleEl.appendChild(artisteEl);
  //   }

  //   return articleEl;
  // }
}
