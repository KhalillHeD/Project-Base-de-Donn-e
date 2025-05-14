  --1
 --donne la meilleur competence en score de un patient

 SELECT nom, competence, score
FROM (
  SELECT p.nom, c.nom_capacite AS competence, MAX(r.score_competence) AS score,
         ROW_NUMBER() OVER (ORDER BY MAX(r.score_competence) DESC) AS rn
  FROM Patient p
  JOIN Resultat r ON p.id_patient = r.id_patient
  JOIN Competence c ON r.id_competence = c.id_competence
  WHERE p.nom = 'Gharbi'
  GROUP BY p.nom, c.nom_capacite
)
WHERE rn = 1;

--2
--most retarted

SELECT p.nom, p.date_naissance, r.age_mental_calcule, 
       (MONTHS_BETWEEN(SYSDATE, p.date_naissance) / 12) - r.age_mental_calcule AS age_gap
FROM Patient p
JOIN Resultat r ON p.id_patient = r.id_patient
ORDER BY age_gap DESC
FETCH FIRST 1 ROWS ONLY;


--3
--Patient qui n'ont jamais attent aucune session
SELECT p.nom, p.prenom
FROM Patient p
LEFT JOIN Assiste_A a ON p.id_patient = a.id_patient
WHERE a.id_session IS NULL;

--4
--les patient qui ont fait evaluation de test PB(id =16 ou just changer)


SELECT p.nom, p.prenom
FROM Patient p
JOIN Resultat r ON p.id_patient = r.id_patient
WHERE r.id_competence = 16;  

--5
--Practitions egager dans une  session spcifique
SELECT pr.om, pr.prenom
FROM Practincien pr
JOIN Session_Formation sf ON pr.id_praticien = sf.id_praticien_anime
WHERE sf.id_session = 2;

--6
--patients avec un  plan de intervention
SELECT p.nom, p.prenom, pi.date_creation, pi.statut
FROM Patient p
JOIN Plan_Intervention pi ON p.id_patient = pi.id_patient;

--7
-- Numbre des evaluations par practiticen
SELECT pr.nom, pr.prenom, COUNT(e.id_evaluation) AS evaluations_count
FROM Practicien pr
JOIN Evaluation e ON pr.id_praticien = e.id_praticien
GROUP BY pr.nom, pr.prenom;


--8
--le plus jeune patient avec le plus grand score dans competence 'AE'
SELECT p.nom,p.prenom, p.date_naissance, r.score_competence
FROM Patient p
JOIN Resultat r ON p.id_patient = r.id_patient
JOIN Competence c ON r.id_competence = c.id_competence
WHERE c.nom_capacite = 'AE'
ORDER BY p.date_naissance DESC, r.score_competence DESC
FETCH FIRST 1 ROWS ONLY;

--9
-- Session avec le plus nombre de patients qui y ont assister
SELECT sf.titre, sf.date_session, COUNT(aa.id_patient) AS patients_attending
FROM Session_Formation sf
JOIN Assiste_A aa ON sf.id_session = aa.id_session
GROUP BY sf.titre, sf.date_session
ORDER BY patients_attending DESC
FETCH FIRST 1 ROWS ONLY;


--10
--patients who scored above a certain threshold (e.g., 80) in a specific competence
SELECT P.nom, P.prenom, R.score_competence
FROM Resultat R
JOIN Patient P ON R.id_patient = P.id_patient
WHERE R.score_competence >4  AND R.id_competence = (SELECT id_competence FROM Competence WHERE nom_capacite = 'PB');

--11
--Track the full progress of a patient across all competencies and evaluations over time

SELECT 
    P.nom AS patient_nom,
    P.prenom AS patient_prenom,
    C.nom_capacite,
    E.date_evaluation,
    R.score_competence
FROM Resultat R
JOIN Competence C ON R.id_competence = C.id_competence
JOIN Evaluation E ON R.id_evaluation = E.id_evaluation
JOIN Patient P ON R.id_patient = P.id_patient
ORDER BY P.nom, C.nom_capacite, E.date_evaluation;


--12
-- Liste des patients inscrits après une date donnée, regroupés par mois d'inscription
SELECT 
    TO_CHAR(date_inscription, 'YYYY-MM') AS mois_inscription,
    COUNT(*) AS nombre_patients
FROM Patient
WHERE date_inscription > TO_DATE('2023-01-01', 'YYYY-MM-DD')
GROUP BY TO_CHAR(date_inscription, 'YYYY-MM')
ORDER BY mois_inscription;

--13
-- Average score per test type for a given patient
SELECT 
    p.nom AS nom_patient,
    t.nom_test AS type_test,
    COUNT(rta.id_restest) AS nombre_de_tests_passes,
    ROUND(AVG(rta.score_brut), 2) AS moyenne_score
FROM 
    resultat_test_autisme rta
JOIN 
    Test t ON rta.id_test = t.id_test
JOIN 
    Patient p ON rta.id_patient = p.id_patient
WHERE 
    p.nom = 'Hadj'  
GROUP BY 
    p.nom, t.nom_test
ORDER BY 
    moyenne_score DESC

--14
--Top Practitioners par numbre des Rendez_vous avec les patients
SELECT 
    pr.nom || ' ' || pr.prenom AS nom_praticien,
    COUNT(rv.id_patient) AS nombre_rendezvous,
    MAX(rv.date_heure) AS dernier_rendezvous,
    MIN(rv.date_heure) AS premier_rendezvous
FROM 
    RendezVous rv
JOIN 
    Practicien pr ON rv.id_praticien = pr.id_praticien
GROUP BY 
    pr.nom, pr.prenom
ORDER BY 
    nombre_rendezvous DESC;

--15
-- Regrouper les événements par mois et par type d’événement
SELECT 
    TO_CHAR(h.date_evenement, 'YYYY-MM') AS mois_evenement,
    h.evenement,
    COUNT(*) AS nombre_evenements
FROM 
    Historique h
GROUP BY 
    TO_CHAR(h.date_evenement, 'YYYY-MM'),
    h.evenement
ORDER BY 
    mois_evenement, nombre_evenements DESC;

    --16
    -- Sélectionner le dernier bilan annuel pour chaque patient
SELECT 
    b.id_bilan,
    b.annee,
    b.synthese,
    b.progres_observes,
    b.id_patient,
    p.nom AS patient_nom,
    p.prenom AS patient_prenom
FROM 
    Bilan_Annuel b
JOIN 
    Patient p ON b.id_patient = p.id_patient
WHERE 
    b.annee = (
        SELECT MAX(annee)
        FROM Bilan_Annuel
        WHERE id_patient = b.id_patient
    )
ORDER BY 
    b.id_patient;

--17

--the top 5 most frequent tests used in evaluations
SELECT T.nom_test,COUNT(RT.id_test) AS nb_utilisations
FROM resultat_test_autisme RT
JOIN Test T ON RT.id_test = T.id_test
GROUP BY T.nom_test
ORDER BY nb_utilisations DESC
FETCH FIRST 5 ROWS ONLY;


--18
-- Objectif : Lister les parents associés à chaque patient
 SELECT P.id_patient, P.nom AS nom_patient, P.prenom AS prenom_patient,
       PR.numCIN_parent, PR.nom AS nom_parent, PR.prenom AS prenom_parent,
       PR.relation_avec_enfant
 FROM Patient P
 LEFT JOIN Parent_patient PE ON P.id_patient = PE.id_patient
 LEFT JOIN Parent PR ON PE.numCIN_parent = PR.numCIN_parent
 ORDER BY P.id_patient;

 --19
--les tests ayant le score moyen le plus élevé dans chaque compétence

 SELECT c.nom_capacite AS competence,AVG(rta.score_brut) AS avg_score
FROM Test t
JOIN Resultat_test_autisme rta ON t.id_test = rta.id_test
JOIN Competence c ON t.id_competence = c.id_competence
GROUP BY c.id_competence, c.nom_capacite
HAVING 
    AVG(rta.score_brut) = (
        SELECT MAX(avg_score)
        FROM (
            SELECT AVG(rta.score_brut) AS avg_score
            FROM Resultat_test_autisme rta
            JOIN Test t ON rta.id_test = t.id_test
            JOIN Competence c ON t.id_competence = c.id_competence
            GROUP BY c.id_competence
        )
    )
ORDER BY 
    avg_score DESC;

--20
-- Centre le plus fréquemment visité par chaque patient

SELECT patient_nom, patient_prenom, nom_centre, nombre_visites
FROM (
    SELECT 
        p.nom AS patient_nom,
        p.prenom AS patient_prenom,
        ce.nom_centre,
        COUNT(*) AS nombre_visites,
        ROW_NUMBER() OVER (
            PARTITION BY p.id_patient 
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM 
        Patient p
    JOIN 
        RendezVous r ON p.id_patient = r.id_patient
    JOIN 
        Centre ce ON r.id_centre = ce.id_centre
    GROUP BY 
        p.id_patient, p.nom, p.prenom, ce.id_centre, ce.nom_centre
)
WHERE rn = 1;


--21
-- Détourer les résultats de test supérieurs à la moyenne générale


SELECT 
    RT.id_resTest, 
    RT.score_brut, 
    RT.date_test, 
    P.nom AS patient_nom, 
    P.prenom AS patient_prenom
FROM 
    Resultat_test_autisme RT
JOIN 
    Patient P ON RT.id_patient = P.id_patient
WHERE 
    RT.score_brut > (SELECT AVG(score_brut) FROM Resultat_test_autisme)
ORDER BY 
    RT.score_brut DESC;


--22
-- Objectif : Détails des tests : nom, difficulté, score brut et observation

 SELECT T.nom_test, T.niveau_difficulte, RT.score_brut, RT.observation
 FROM Resultat_test_autisme RT
 JOIN Test T ON RT.id_test = T.id_test
 ORDER BY RT.score_brut DESC, T.niveau_difficulte;


--23
--Liste des équipes, leurs praticiens, et les plans d'intervention associés


SELECT 
    eq.nom_equipe,
    pr.nom AS praticien_nom,
    pr.prenom AS praticien_prenom,
    pi.id_plan,
    pi.objectifs,
    pi.statut
FROM 
    Equipe eq
JOIN 
    Practicien pr ON eq.id_praticien = pr.id_praticien
JOIN 
    Plan_Intervention pi ON eq.id_equipe = pi.id_equipe
ORDER BY 
    eq.nom_equipe, pr.nom, pi.date_creation DESC;

--24

-- Objectif : Plans d'intervention dont les objectifs contiennent le mot 'com
 SELECT id_plan, objectifs, statut
 FROM Plan_Intervention
 WHERE LOWER(objectifs) LIKE '%communication%';


--25


-- Objectif : Délai moyen entre création et révision des plans d'intervention

 SELECT ROUND(AVG(date_revision - date_creation),2) AS delai_moyen_jours
 FROM Plan_Intervention
 WHERE date_revision IS NOT NULL;

--26

--Grouper les patients par âge et afficher leur nombre dans chaque groupe d'âge
SELECT 
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.date_naissance) AS age, 
    COUNT(*) AS nombre_patients
FROM 
    Patient p
GROUP BY 
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.date_naissance)
ORDER BY 
    age;

--27

-- Liste des parents qui sont également des praticiens
-- Supposition : Il n'y a pas deux praticiens avec le même nom et prénom.
SELECT 
    p.nom AS parent_nom, 
    p.prenom AS parent_prenom
FROM 
    Parent p
JOIN 
    Practicien pr ON p.nom = pr.nom AND p.prenom = pr.prenom
ORDER BY 
    p.nom, p.prenom;
--28
-- Patients qui ont passé tous les tests liés à la compétence PB
WITH tests_PB AS (
    SELECT id_test
    FROM Test
    WHERE id_competence = (SELECT id_competence FROM Competence WHERE nom_capacite = 'PB')
),
patients_ayant_tous_les_tests_PB AS (
    SELECT rta.id_patient
    FROM Patient p
    JOIN Resultat_test_autisme rta ON p.id_patient = rta.id_patient
    WHERE rta.id_test IN (SELECT id_test FROM tests_PB)
    GROUP BY rta.id_patient
    HAVING COUNT(DISTINCT rta.id_test) = (SELECT COUNT(*) FROM tests_PB)
),
patients_avec_plan_actif AS (
    SELECT DISTINCT id_patient
    FROM Plan_Intervention
    WHERE statut = 'Actif'
)

-- Résultat final : patients ayant fait tous les tests PB mais sans plan actif
SELECT p.id_patient, p.nom, p.prenom
FROM Patient p
WHERE p.id_patient IN (SELECT id_patient FROM patients_ayant_tous_les_tests_PB)
MINUS
SELECT p.id_patient, p.nom, p.prenom
FROM Patient p
WHERE p.id_patient IN (SELECT id_patient FROM patients_avec_plan_actif);

--29
SELECT 
    patient_nom,
    nom_capacite,
    MIN(date_test) AS date_premier_test,
    MAX(date_test) AS date_dernier_test,
    MIN(premier_score) AS premier_score,
    MAX(dernier_score) AS dernier_score
FROM (
    SELECT 
        p.nom AS patient_nom,
        c.nom_capacite,
        rt.date_test,
        FIRST_VALUE(rt.score_brut) OVER (PARTITION BY p.id_patient, c.id_competence ORDER BY rt.date_test) AS premier_score,
        LAST_VALUE(rt.score_brut) OVER (
            PARTITION BY p.id_patient, c.id_competence 
            ORDER BY rt.date_test 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS dernier_score
    FROM Resultat_test_autisme rt
    JOIN Patient p ON rt.id_patient = p.id_patient
    JOIN Test t ON rt.id_test = t.id_test
    JOIN Competence c ON t.id_competence = c.id_competence
    WHERE p.nom = 'Hadj'
)
GROUP BY patient_nom, nom_capacite;


--30
-- Compétences pour lesquelles aucun test n’a été encore passé par un patient
SELECT 
    c.id_competence, 
    c.nom_capacite
FROM 
    Competence c
WHERE 
    c.id_competence NOT IN (
        SELECT DISTINCT t.id_competence
        FROM Test t
        JOIN Resultat_test_autisme rta ON t.id_test = rta.id_test
    )
ORDER BY 
    c.nom_capacite;




-- 🔎 Requête : Rendez-vous après le 25/05/2025 pour patients avec écart développemental > 2 ans

SELECT 
    p.nom AS patient_nom,
    p.prenom AS patient_prenom,
    TO_CHAR(rv.date_heure, 'YYYY-MM-DD HH24:MI') AS date_rendez_vous,
    pr.nom AS praticien_nom,
    pr.prenom AS praticien_prenom,
    c.nom_centre
FROM 
    RendezVous rv
JOIN 
    Patient p ON rv.id_patient = p.id_patient
JOIN 
    Practicien pr ON rv.id_praticien = pr.id_praticien
JOIN 
    Centre c ON rv.id_centre = c.id_centre
JOIN 
    (
        SELECT 
            r.id_patient,
            ROUND(AVG(r.age_mental_calcule), 1) AS age_mental_moyen
        FROM 
            Resultat r
        GROUP BY 
            r.id_patient
    ) am ON p.id_patient = am.id_patient
WHERE 
    (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.date_naissance)) - am.age_mental_moyen < 5
    AND rv.date_heure > TO_DATE('2025-04-25', 'YYYY-MM-DD')
ORDER BY 
    rv.date_heure DESC;


