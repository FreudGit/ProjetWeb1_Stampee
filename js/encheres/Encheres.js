export default class EncheresApp {
  #data;
  #dataItems;
  #displayTarget;
  #resultsEL;
  #countEL;
  searchString;
  #originalData;
  favorisType;
  categorieType;
  certificatType;


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
    console.log("filterAndDisplay: searchString", searchString);
    this.searchString = searchString;
    this.#dataItems = this.#originalData;

    let filteredItems = this.filterBySearch();
    filteredItems = this.filterByFavoris(this.favorisType, filteredItems);
    filteredItems = this.filterByCategories(this.categorieType, filteredItems);
    filteredItems = this.filterByCertificats(this.certificatType, filteredItems);
    this.#dataItems=filteredItems;

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
      carteItem.classList.remove("hidden");
    }
    console.log("displayItems: carteItems(array)", items);

  }

  updateUrlParam(paramName, paramValue) {
    var url = new URL(window.location.href);
    url.searchParams.set(paramName, paramValue);
    window.history.pushState({ path: url.href }, "", url.href);
  }

  filterBySearch(searchString = this.searchString, items = this.#dataItems) {
    const url = new URL(window.location.href);
    this.updateUrlParam("search", searchString);
    console.log("filterBySearch searchString", searchString);
    //filter array items. Item.DateFin should indlude searchString
    const filteredItems = items.filter((item) => {
      if (searchString === "") return true;
      if (item.TimbreNom === null) return false;
      const itemDateFin = item.TimbreNom;
      const lc = itemDateFin.toLowerCase();
      const filter = searchString.toLowerCase();
      const bFound = lc.includes(filter);
      if (bFound) {
        const carteItem = document.getElementById("Enchere" + item.ID);
        carteItem.classList.add("hidden");
      }
      return bFound;
    });
    console.log("filterBySearch filteredItems", filteredItems);

    return filteredItems;
  }

  /**
   * filtre les items selon le type de favoris
   * @param {*} sType type de favoris
   * @param {*} items items à filtrer
   * @returns items filtrés
   */
  filterByFavoris(sType = this.favorisType, items = this.#dataItems) {
    this.updateUrlParam("favoris", sType);
    console.log("filterByFav items avant recherche", sType, items);

    const filteredItems = items.filter((item) => {
      let favItem = "";
      if (sType === "FavorisLord") {
        favItem = item.bFavorisLord;
      } else if (sType === "FavorisUsager") {
        favItem = item.bFavoris;
      } else {
        favItem = 1;
      }

      if (parseInt(favItem) == 1) {
        return true;
      }
      return false;
    });
    console.log("filterByFav filteredItems", filteredItems);
    return filteredItems;
  }


 /**
   * filtre les items selon le type de favoris
   * @param {*} sType type de favoris
   * @param {*} items items à filtrer
   * @returns items filtrés
   */
  filterByCategories(sType = this.categorieType, items = this.#dataItems) {
    this.updateUrlParam("categorie", sType);
    console.log("filterByCategories sType", sType);
    console.log("filterByCategories items avant recherche", items);
    if (sType === "Toutes") {
      return items;
    }
    const filteredItems = items.filter((item) => {
      if (item.CategorieID == sType) {
        return true;
      }
      return false;
    });
    console.log("filterByCategories filteredItems", filteredItems);
    return filteredItems;
  }



  /**
   * filtre les items selon le type de favoris
   * @param {*} sType type de favoris
   * @param {*} items items à filtrer
   * @returns items filtrés
   */
  filterByCertificats(sType = this.certificatType, items = this.#dataItems) {
    this.updateUrlParam("certificat", sType);
    console.log("filterByCertificats items avant recherche", sType, items);
    if (sType === "Toutes") {
      return items;
    }
    const filteredItems = items.filter((item) => {
      if (item.TimbreCertifie == null) {
        item.TimbreCertifie = 0;
      }
      if (parseInt(item.TimbreCertifie) == sType) {
        return true;
      }
      return false;
    });
    console.log("filterByCertificats filteredItems", filteredItems);
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
    this.#resultsEL.textContent = this.#dataItems.length + ' items trouvés(filtrés). Voici les résultats 1 à ' + this.#dataItems.length;
  }

  /**
   * Ajouter ou retirer aux favoris
   * @param {HTMLElement} element - Élément HTML qui a été cliqué
   * @returns {boolean} - true si l'enchère a été ajoutée aux favoris, false sinon
   *
   **/
  toggleFavoris(element) {
    const currentTarget = element.currentTarget;
    const app = new EncheresApp();
    const fd = new FormData();
    fd.append(
      "enchereID",
      element.currentTarget.getAttribute("data-enchere-id")
    );
    fd.append(
      "utilisateurID",
      element.currentTarget.getAttribute("data-user-id")
    );

    let $action;
    const bIsFav=!(element.currentTarget.classList.contains("selected"))
    if (bIsFav) {
      $action = "retirerEnchereAFavorisFromPost";
    } else {
      $action = "ajouterEnchereAFavorisFromPost";
    }
    currentTarget.classList.toggle("selected");
    console.log($action, fd);
    fetch($action, {
      method: "POST",
      body: fd,
    })
      .then(function (response) {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error("Error: " + response.status);
        }
      })
      .then(function (data) {
        console.log("Response " + $action, data);
       
      })
      .catch(function (error) {
        console.error("Error " + $action, error);
        //echec de la sauvegarde, on replace l'état précédent
        currentTarget.classList.toggle("selected");
      });
  }
}
