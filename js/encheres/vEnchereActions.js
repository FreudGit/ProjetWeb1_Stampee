///////////////////////////////////////////////////////////////////////////////
// Ce fichier contient le code lié à l'interface usager du site Web. Le code
// concernant l'état et le comportement du site se trouve dans la classe `Encheres`.

import EncheresApp from "./Encheres.js";
//const mainEL = document.querySelector("main");
//const app = new EncheresApp();
//const frmDropDownFavoris = document.querySelector("#frmDropDownFavoris");
const btnAjouterFavoris = document.querySelector("#btnAjouterFavoris");
btnAjouterFavoris.addEventListener("click", (element) => {
  element.preventDefault();
  let appl = new EncheresApp();
  appl.ajouterFavoris(element);
  return true;

  const currentTarget = element.currentTarget;
  const app = new EncheresApp();
  const fd = new FormData();
  fd.append("enchereID", element.currentTarget.getAttribute("data-enchere-id"));
  fd.append(
    "utilisateurID",
    element.currentTarget.getAttribute("data-user-id")
  );

  let $action;
  if (element.currentTarget.classList.contains("selected")) {
    $action = "retirerEnchereAFavorisFromPost";
  } else {
    $action = "ajouterEnchereAFavorisFromPost";
  }

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
      console.log("Response:", data);
      currentTarget.classList.toggle("selected");
    })
    .catch(function (error) {
      console.error("Error:", error);
    });
});
