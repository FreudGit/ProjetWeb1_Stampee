INSERT INTO Utilisateur (Nom, Rue, CodePostal, Ville, Pays, Email, MotDePasse, DateInscription, Valide, Rating)
VALUES
  ('John Doe', '123 Rue de la Poste', '12345', 'Villeville', 'Paysville', 'john.doe@example.com', 'motdepasse1', '2022-01-01', TRUE, 4.5),
  ('Jane Smith', '456 Avenue du Timbre', '67890', 'Villetimbre', 'Paystimbre', 'jane.smith@example.com', 'motdepasse2', '2022-02-01', TRUE, 4.2),
  ('Robert Johnson', '789 Rue Principale', '54321', 'Villeprincipale', 'Paysprincipal', 'robert.johnson@example.com', 'motdepasse3', '2022-03-01', TRUE, 4.7),
  ('Sarah Wilson', '987 Avenue des Philatélistes', '98765', 'Villephilatelie', 'Paysphilatelie', 'sarah.wilson@example.com', 'motdepasse4', '2022-04-01', TRUE, 4.1),
  ('Michael Brown', '654 Rue des Collectionneurs', '32109', 'Villecollection', 'Payscollection', 'michael.brown@example.com', 'motdepasse5', '2022-05-01', TRUE, 4.9);




  


INSERT INTO Categorie (Nom)
VALUES
  ('Animaux'),
  ('Personnages célèbres'),
  ('Nature'),
  ('Sports'),
  ('Histoire');

INSERT INTO Timbre (Nom, DateCreation, Couleur, PaysOrigine, EtatCondition, Tirage, Longueur, Largeur, Certifie, CategorieID)
VALUES
  ('Timbre Animaux 1', '2021-01-01', 'Multicolore', 'Paysville', 'Neuf sans charnière', 10000, 30.5, 20.5, TRUE, 1),
  ('Timbre Animaux 2', '2021-02-01', 'Noir et blanc', 'Paysville', 'Oblitéré', 5000, 25.0, 15.0, FALSE, 1),
  ('Timbre Célébrités 1', '2021-03-01', 'Multicolore', 'Paystimbre', 'Neuf avec charnière', 8000, 35.0, 25.0, TRUE, 2),
  ('Timbre Célébrités 2', '2021-04-01', 'Noir et blanc', 'Paystimbre', 'Oblitéré', 4000, 30.0, 20.0, FALSE, 2),
  ('Timbre Nature 1', '2021-05-01', 'Multicolore', 'Paysprincipal', 'Neuf sans charnière', 6000, 40.0, 30.0, TRUE, 3);

INSERT INTO Image (TimbreID, CheminImage, Visible, Description, Ordre)
VALUES
  (1, 'images/timbre_animaux_1.jpg', TRUE, 'Image du timbre Animaux 1', 1),
  (1, 'images/timbre_animaux_1_back.jpg', TRUE, 'Image au dos du timbre Animaux 1', 2),
  (2, 'images/timbre_animaux_2.jpg', TRUE, 'Image du timbre Animaux 2', 1),
  (3, 'images/timbre_celebrites_1.jpg', TRUE, 'Image du timbre Célébrités 1', 1),
  (4, 'images/timbre_celebrites_2.jpg', TRUE, 'Image du timbre Célébrités 2', 1);


INSERT INTO Enchere (TimbreID, UtilisateurID, DateDebut, DateFin, PrixPlancher, UtilisateurActuelID, Visible, Status, Rating)
VALUES
  (1, 1, '2023-01-01', '2023-01-31', 10.00, 1, TRUE, 'En cours', 4.0),
  (2, 2, '2023-02-01', '2023-02-28', 15.00, 2, TRUE, 'En cours', 4.2),
  (3, 3, '2023-03-01', '2023-03-31', 20.00, 3, TRUE, 'En cours', 4.5),
  (4, 4, '2023-04-01', '2023-04-30', 25.00, 4, TRUE, 'En cours', 4.7),
  (5, 5, '2023-05-01', '2023-05-31', 30.00, 5, TRUE, 'En cours', 4.9);

  INSERT INTO Offre (ID, EnchereID, UtilisateurID, Prix, Visible, Status)
VALUES
    (1, 1, 1, 10.00, 1, 'Acceptée'),
    (2, 1, 2, 12.50, 1, 'Acceptée'),
    (3, 1, 3, 15.00, 1, 'Acceptée'),
    (4, 2, 1, 20.00, 1, 'Acceptée'),
    (5, 2, 3, 22.50, 1, 'Acceptée'),
    (6, 3, 2, 30.00, 1, 'Acceptée'),
    (7, 3, 3, 32.50, 1, 'Acceptée'),
    (8, 4, 1, 40.00, 1, 'Acceptée'),
    (9, 4, 2, 42.50, 1, 'Acceptée'),
    (10, 4, 3, 45.00, 1, 'Acceptée');

INSERT INTO Transaction (ID, EnchereID, UtilisateurID, Montant, ModePaiement, DateTransaction)
VALUES
    (1, 1, 3, 15.00, 'PayPal', '2022-01-01'),
    (2, 2, 1, 20.00, 'Virement', '2022-02-01'),
    (3, 4, 2, 42.50, 'Carte crédit', '2022-03-01'),
    (4, 4, 3, 45.00, 'PayPal', '2022-03-01');