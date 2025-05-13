-- First clear existing data if needed
TRUNCATE TABLE Patient;

-- Insert patients one by one
INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Al-Mansour', 'Youssef', TO_DATE('1998-05-12', 'YYYY-MM-DD'), 'TRIS-001', 'M', TO_DATE('2021-03-15', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Ben Ammar', 'Leila', TO_DATE('2002-11-03', 'YYYY-MM-DD'), 'TRIS-002', 'F', TO_DATE('2021-06-22', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('El-Sayed', 'Karim', TO_DATE('1995-08-25', 'YYYY-MM-DD'), 'TRIS-003', 'M', TO_DATE('2021-09-10', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Abdullah', 'Amina', TO_DATE('2005-02-18', 'YYYY-MM-DD'), 'TRIS-004', 'F', TO_DATE('2021-11-05', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Al-Farsi', 'Omar', TO_DATE('2001-09-30', 'YYYY-MM-DD'), 'TRIS-005', 'M', TO_DATE('2022-01-18', 'YYYY-MM-DD'));

-- Next 5 patients registered 1-2 years ago  
INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Al-Hashimi', 'Rami', TO_DATE('1997-04-14', 'YYYY-MM-DD'), 'TRIS-006', 'M', TO_DATE('2022-04-14', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Bouaziz', 'Nadia', TO_DATE('2003-12-08', 'YYYY-MM-DD'), 'TRIS-007', 'F', TO_DATE('2022-07-30', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Cherif', 'Samir', TO_DATE('1999-07-19', 'YYYY-MM-DD'), 'TRIS-008', 'M', TO_DATE('2022-09-12', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Daoud', 'Lina', TO_DATE('2004-05-27', 'YYYY-MM-DD'), 'TRIS-009', 'F', TO_DATE('2022-11-08', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Essaidi', 'Tariq', TO_DATE('1996-10-31', 'YYYY-MM-DD'), 'TRIS-010', 'M', TO_DATE('2023-01-25', 'YYYY-MM-DD'));

-- Recent patients registered within the last year
INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Fahmy', 'Yasmin', TO_DATE('2000-02-11', 'YYYY-MM-DD'), 'TRIS-011', 'F', TO_DATE('2023-03-17', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Ghannam', 'Adel', TO_DATE('1994-12-05', 'YYYY-MM-DD'), 'TRIS-012', 'M', TO_DATE('2023-05-09', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Hamdi', 'Soraya', TO_DATE('2006-08-23', 'YYYY-MM-DD'), 'TRIS-013', 'F', TO_DATE('2023-06-14', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Ibrahim', 'Khalid', TO_DATE('1993-04-16', 'YYYY-MM-DD'), 'TRIS-014', 'M', TO_DATE('2023-08-21', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Jabbar', 'Mona', TO_DATE('2007-01-09', 'YYYY-MM-DD'), 'TRIS-015', 'F', TO_DATE('2023-09-30', 'YYYY-MM-DD'));

-- Most recent patients (last 3 months)
INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Khalil', 'Ziad', TO_DATE('1998-06-28', 'YYYY-MM-DD'), 'TRIS-016', 'M', TO_DATE('2023-10-15', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Laroui', 'Hana', TO_DATE('2002-03-07', 'YYYY-MM-DD'), 'TRIS-017', 'F', TO_DATE('2023-11-02', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Malouf', 'Nabil', TO_DATE('1995-09-14', 'YYYY-MM-DD'), 'TRIS-018', 'M', TO_DATE('2023-11-18', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Nouri', 'Dalia', TO_DATE('2003-07-21', 'YYYY-MM-DD'), 'TRIS-019', 'F', TO_DATE('2023-12-05', 'YYYY-MM-DD'));

INSERT INTO Patient (nom, prenom, date_naissance, num_dossier, sexe, date_inscription)
VALUES ('Othman', 'Waleed', TO_DATE('1999-12-12', 'YYYY-MM-DD'), 'TRIS-020', 'M', TO_DATE('2023-12-20', 'YYYY-MM-DD'));

-- View the results
SELECT * FROM Patient ORDER BY date_inscription DESC;

INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Ben Ammar', 'Mohamed', 'Cardiologie', 'm.benammar@cardio.tn', 'CAR12345678');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Trabelsi', 'Fatma', 'Pédiatrie', 'f.trabelsi@pediatrie.tn', 'PED23456789');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Masmoudi', 'Ali', 'Neurologie', 'a.masmoudi@neuro.tn', 'NEU34567890');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Bouazizi', 'Amina', 'Gynécologie', 'a.bouazizi@gyno.tn', 'GYN45678901');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Gharbi', 'Youssef', 'Orthopédie', 'y.gharbi@ortho.tn', 'ORT56789012');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Saidi', 'Leila', 'Dermatologie', 'l.saidi@derma.tn', 'DER67890123');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Haddad', 'Karim', 'Chirurgie générale', 'k.haddad@chirurgie.tn', 'CHI78901234');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Chaabane', 'Samira', 'Ophtalmologie', 's.chaabane@ophtalmo.tn', 'OPH89012345');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Abid', 'Nabil', 'Radiologie', 'n.abid@radio.tn', 'RAD90123456');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Karray', 'Houda', 'Psychiatrie', 'h.karray@psychiatrie.tn', 'PSY01234567');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Zouari', 'Riadh', 'Urologie', 'r.zouari@uro.tn', 'URO12345098');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Boussaid', 'Salma', 'Endocrinologie', 's.boussaid@endo.tn', 'END23456709');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Mejri', 'Wassim', 'Pneumologie', 'w.mejri@pneumo.tn', 'PNE34567801');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Ben Salah', 'Ines', 'Rhumatologie', 'i.bensalah@rhumato.tn', 'RHU45678912');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Jemai', 'Omar', 'Gastro-entérologie', 'o.jemai@gastro.tn', 'GAS56789023');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Mansouri', 'Amira', 'Oncologie', 'a.mansouri@onco.tn', 'ONC67890134');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Ben Youssef', 'Adel', 'Anesthésiologie', 'a.benyoussef@anesthesie.tn', 'ANE78901245');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Fersi', 'Mouna', 'Médecine interne', 'm.fersi@medinterne.tn', 'INT89012356');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Ayari', 'Tarek', 'ORL', 't.ayari@orl.tn', 'ORL90123467');
INSERT INTO Practicien (nom, prenom, specialite, email, num_professionnel) VALUES ('Guesmi', 'Nadia', 'Néphrologie', 'n.guesmi@nephro.tn', 'NEP01234578');

-- Evaluation 1: Genetic screening at Centre Tunisien du Syndrome de Down (id_centre=1)
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Dépistage génétique', TO_DATE('15/03/2024', 'DD/MM/YYYY'), 1, 1);

-- Evaluation 2: Developmental assessment at Centre Lina (id_centre=2)
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Évaluation du développement moteur', TO_DATE('22/03/2024', 'DD/MM/YYYY'), 2, 2);

-- Evaluation 3: Speech therapy evaluation at Centre Espoir (id_centre=3)
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Bilan orthophonique', TO_DATE('05/04/2024', 'DD/MM/YYYY'), 5, 3);

-- Evaluation 4: Genetic confirmation at Laboratoire Généticare (id_centre=4)
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Caryotype confirmatoire', TO_DATE('12/04/2024', 'DD/MM/YYYY'), 10, 4);

-- Evaluation 5: Multidisciplinary evaluation at Centre Rayane (id_centre=5)
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Évaluation pluridisciplinaire', TO_DATE('18/04/2024', 'DD/MM/YYYY'), 15, 5);

-- Evaluation 6: Follow-up at Centre Tunisien du Syndrome de Down
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Suivi annuel', TO_DATE('25/04/2024', 'DD/MM/YYYY'), 1, 1);

-- Evaluation 7: Cognitive assessment at Centre Lina
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Test QI adapté', TO_DATE('02/05/2024', 'DD/MM/YYYY'), 2, 2);

-- Evaluation 8: Parental counseling at Centre Espoir
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Consultation psychologique familiale', TO_DATE('09/05/2024', 'DD/MM/YYYY'), 5, 3);

-- Evaluation 9: Blood test at Laboratoire Généticare
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Prélèvement sanguin', TO_DATE('16/05/2024', 'DD/MM/YYYY'), 10, 4);

-- Evaluation 10: Early intervention planning at Centre Rayane
INSERT INTO Evaluation (type_evaluation, date_evaluation, id_praticien, id_centre)
VALUES ('Plan d intervention précoce', TO_DATE('23/05/2024', 'DD/MM/YYYY'), 15, 5);


-- Patient 141: Youssef Al-Mansour (24 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023, 
'Patient adulte avec trisomie 21 montrant une bonne autonomie dans les activités quotidiennes. Travaille à l atelier protégé 3 jours/semaine.',
'Amélioration notable en communication orale. Progrès dans la gestion de l argent de poche. A besoin de soutien pour les transports en commun.',
141);

-- Patient 142: Leila Ben Ammar (20 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Jeune femme avec trisomie 21 et hypothyroïdie bien contrôlée. Fréquente un centre de formation professionnelle.',
'Acquisition de compétences en cuisine simple. Difficultés persistantes en lecture. Excellente intégration sociale.',
142);

-- Patient 143: Karim El-Sayed (27 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Patient présentant une trisomie 21 avec cardiopathie opérée. Vit en foyer médicalisé.',
'Stabilité médicale. Progrès en hygiène personnelle. Comportements stéréotypés réduits grâce à la nouvelle médication.',
143);

-- Patient 144: Amina Abdullah (18 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Transition réussie vers le centre pour adultes. Présente un retard de langage important mais une grande expressivité non verbale.',
'Apprentissage de 20 nouveaux mots cette année. Utilisation croissante de la tablette pour communiquer. Épisodes de frustration moins fréquents.',
144);

-- Patient 145: Omar Al-Farsi (21 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Jeune homme avec mosaïcisme trisomique. Performances cognitives supérieures à la moyenne du groupe.',
'A réussi son certificat de formation en jardinage. Conduit un projet de potager communautaire. Difficultés persistantes en calcul.',
145);

-- Patient 146: Rami Al-Hashimi (25 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Patient avec trisomie 21 et apnée du sommeil traitée. Vit avec sa famille qui fournit un excellent soutien.',
'Apprentissage réussi du vélo adapté. Participation à des compétitions sportives spécialisées. Aggravation de la myopie nécessitant un nouveau suivi ophtalmologique.',
146);

-- Patient 147: Nadia Bouaziz (19 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Adolescente avec trisomie 21 et autisme associé. Progrès significatifs depuis l introduction de la méthode TEACCH.',
'Réduction de 60% des crises de colère. Premiers signes de communication fonctionnelle. Commence à tolérer les contacts physiques.',
147);

-- Patient 148: Samir Cherif (23 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Jeune homme avec trisomie 21 et épilepsie bien contrôlée. Travaille comme assistant en bibliothèque.',
'Capacité accrue à classer les livres par catégories. Apprentissage de l utilisation du système de prêt informatisé. A développé une passion pour la musique arabo-andalouse.',
148);

-- Patient 149: Lina Daoud (18 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Transition vers la vie adulte. Présente des capacités artistiques remarquables malgré un retard cognitif important.',
'Exposition de ses peintures dans 2 galeries locales. Amélioration de l autonomie vestimentaire. Difficultés persistantes en gestion du temps.',
149);

-- Patient 150: Tariq Essaidi (26 years old)
INSERT INTO Bilan_Annuel (annee, synthese, progres_observes, id_patient)
VALUES (2023,
'Patient avec trisomie 21 et obésité modérée. Programme de réadaptation physique en cours.',
'Perte de 8 kg cette année. Participation régulière aux activités sportives adaptées. Apprentissage de la natation.',
150);


