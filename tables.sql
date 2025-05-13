CREATE TABLE Patient (
    id_patient        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom               VARCHAR2(100) NOT NULL,
    prenom            VARCHAR2(100),
    date_naissance    DATE,
    num_dossier       VARCHAR2(50) UNIQUE,
    sexe              CHAR(1),
    date_inscription  DATE
);

CREATE TABLE Practicien (
    id_praticien      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom               VARCHAR2(100) NOT NULL,
    prenom            VARCHAR2(100),
    specialite        VARCHAR2(100),
    email             VARCHAR2(100),
    num_professionnel VARCHAR2(50)
);

CREATE TABLE Centre (
    id_centre         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_centre        VARCHAR2(100) NOT NULL,
    email_centre      VARCHAR2(100),
    telephone         VARCHAR2(20),
    responsable       VARCHAR2(100)
);

CREATE TABLE Competence (
    id_competence     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_capacite      VARCHAR2(100) NOT NULL,
    description_capacite CLOB
);

CREATE TABLE Test (
    id_test           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_test          VARCHAR2(100) NOT NULL,
    description_test  CLOB,
    niveau_difficulte NUMBER,
    id_competence     NUMBER NOT NULL,
    CONSTRAINT fk_test_competence FOREIGN KEY(id_competence)
      REFERENCES Competence(id_competence)
);

CREATE TABLE Resultat_test (
    id_resTest        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    score_brut        NUMBER,
    observation       VARCHAR2(4000),
    date_test         DATE,
    id_test           NUMBER NOT NULL,
    CONSTRAINT fk_rt_test FOREIGN KEY(id_test)
      REFERENCES Test(id_test)
);

CREATE TABLE Evaluation (
    id_evaluation     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_evaluation   VARCHAR2(100),
    date_evaluation   DATE,
    id_praticien      NUMBER NOT NULL,
    id_centre         NUMBER NOT NULL,
    CONSTRAINT fk_eval_praticien FOREIGN KEY(id_praticien)
      REFERENCES Practicien(id_praticien),
    CONSTRAINT fk_eval_centre FOREIGN KEY(id_centre)
      REFERENCES Centre(id_centre)
);

CREATE TABLE Resultat (
    id_resultat       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    score_competence  NUMBER,
    observation       VARCHAR2(4000),
    age_mental_calcule NUMBER,
    id_evaluation     NUMBER NOT NULL,
    id_patient        NUMBER NOT NULL,
    id_competence     NUMBER, 
    CONSTRAINT fk_res_eval FOREIGN KEY(id_evaluation)
      REFERENCES Evaluation(id_evaluation),
    CONSTRAINT fk_res_patient FOREIGN KEY(id_patient)
      REFERENCES Patient(id_patient),
    CONSTRAINT fk_res_competence FOREIGN KEY(id_competence)
      REFERENCES Competence(id_competence)
);


CREATE TABLE Historique (
    id_historique     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    evenement         VARCHAR2(200),
    date_evenement    DATE,
    commentaire       CLOB,
    id_evaluation     NUMBER NOT NULL,
    CONSTRAINT fk_hist_eval FOREIGN KEY(id_evaluation)
      REFERENCES Evaluation(id_evaluation)
);

CREATE TABLE Session_Formation (
    id_session        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titre             VARCHAR2(200),
    date_session      DATE,
    contenu           CLOB,
    id_praticien_propose NUMBER NOT NULL,
    id_praticien_anime   NUMBER NOT NULL,
    id_centre            NUMBER NOT NULL,
    CONSTRAINT fk_sf_propose FOREIGN KEY(id_praticien_propose)
      REFERENCES Practicien(id_praticien),
    CONSTRAINT fk_sf_anime FOREIGN KEY(id_praticien_anime)
      REFERENCES Practicien(id_praticien),
    CONSTRAINT fk_sf_centre FOREIGN KEY(id_centre)
      REFERENCES Centre(id_centre)
);


CREATE TABLE Bilan_Annuel (
    id_bilan          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    annee             NUMBER,
    synthese          CLOB,
    progres_observes  CLOB,
    id_patient        NUMBER NOT NULL,
    CONSTRAINT fk_bilan_patient FOREIGN KEY(id_patient)
      REFERENCES Patient(id_patient)
);
CREATE TABLE Equipe (
    id_equipe     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_equipe    VARCHAR2(100) NOT NULL,
    id_praticien  NUMBER,
    CONSTRAINT fk_equipe_praticien FOREIGN KEY(id_praticien)
      REFERENCES Practicien(id_praticien)
);

CREATE TABLE Parent (
    numCIN_parent     VARCHAR2(20) PRIMARY KEY,
    nom               VARCHAR2(100),
    prenom            VARCHAR2(100),
    relation_avec_enfant VARCHAR2(100),
    telephone         VARCHAR2(20),
    email             VARCHAR2(100)
);

CREATE TABLE Plan_Intervention (
    id_plan           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_creation     DATE,
    objectifs         CLOB,
    statut            VARCHAR2(50),
    date_revision     DATE,
    id_patient        NUMBER NOT NULL,
    id_praticien      NUMBER NOT NULL,
    id_equipe         NUMBER NOT NULL,
    CONSTRAINT fk_plan_patient FOREIGN KEY(id_patient)
      REFERENCES Patient(id_patient),
    CONSTRAINT fk_plan_praticien FOREIGN KEY(id_praticien)
      REFERENCES Practicien(id_praticien),
    CONSTRAINT fk_plan_equipe FOREIGN KEY(id_equipe)
      REFERENCES Equipe(id_equipe)
);
-- Tables d'association (relations N–N)

CREATE TABLE Assiste_A (
    id_session        NUMBER NOT NULL,
    id_patient        NUMBER NOT NULL,
    PRIMARY KEY(id_session, id_patient),
    CONSTRAINT fk_assiste_session FOREIGN KEY(id_session)
      REFERENCES Session_Formation(id_session),
    CONSTRAINT fk_assiste_patient FOREIGN KEY(id_patient)
      REFERENCES Patient(id_patient)
);

CREATE TABLE Teste (
    id_praticien      NUMBER NOT NULL,
    id_patient        NUMBER NOT NULL,
    PRIMARY KEY(id_praticien, id_patient),
    CONSTRAINT fk_teste_praticien FOREIGN KEY(id_praticien)
      REFERENCES Practicien(id_praticien),
    CONSTRAINT fk_teste_patient FOREIGN KEY(id_patient)
      REFERENCES Patient(id_patient)
);

CREATE TABLE Cible_Par (
    id_plan           NUMBER NOT NULL,
    id_competence     NUMBER NOT NULL,
    PRIMARY KEY(id_plan, id_competence),
    CONSTRAINT fk_cible_plan FOREIGN KEY(id_plan)
      REFERENCES Plan_Intervention(id_plan),
    CONSTRAINT fk_cible_comp FOREIGN KEY(id_competence)
      REFERENCES Competence(id_competence)
);

CREATE TABLE Parent_Patient (
    numCIN_parent     VARCHAR2(20) NOT NULL,
    id_patient        NUMBER NOT NULL,
    PRIMARY KEY(numCIN_parent, id_patient),
    CONSTRAINT fk_pp_parent FOREIGN KEY(numCIN_parent)
      REFERENCES Parent(numCIN_parent),
    CONSTRAINT fk_pp_patient FOREIGN KEY(id_patient)
      REFERENCES Patient(id_patient)
);

-- Relations porteuses de données

-- RendezVous entre Patient et Practicien
CREATE TABLE RendezVous (
    id_patient        NUMBER NOT NULL,
    id_praticien      NUMBER NOT NULL,
    date_heure        TIMESTAMP NOT NULL,
    type_rdv          VARCHAR2(50),
    motif             VARCHAR2(4000),
    PRIMARY KEY(id_patient, id_praticien, date_heure),
    CONSTRAINT fk_rdv_patient FOREIGN KEY(id_patient)
      REFERENCES Patient(id_patient),
    CONSTRAINT fk_rdv_centre FOREIGN KEY(id_centre)
      REFERENCES Centre(id_centre)
);

-- Passe: enregistrement du passage d'une évaluation par un patient
CREATE TABLE Passe (
    id_patient        NUMBER NOT NULL,
    id_evaluation     NUMBER NOT NULL,
    PRIMARY KEY(id_patient, id_evaluation),
    CONSTRAINT fk_passe_patient FOREIGN KEY(id_patient)
      REFERENCES Patient(id_patient),
    CONSTRAINT fk_passe_eval FOREIGN KEY(id_evaluation)
      REFERENCES Evaluation(id_evaluation)
);