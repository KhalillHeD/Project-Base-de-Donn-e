--remplissage de resultat_test_autisme de 4 personne 3 5 7 9

DECLARE
  v_patient_ids SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(3, 5, 7, 9);
  v_base_date DATE := TO_DATE('2025-04-01', 'YYYY-MM-DD');
BEGIN
  FOR p IN 1 .. v_patient_ids.COUNT LOOP
    FOR test_id IN 6 .. 44 LOOP
      INSERT INTO resultat_test_autisme (
        score_brut,
        observation,
        date_test,
        id_test,
        id_patient
      ) VALUES (
        TRUNC(DBMS_RANDOM.VALUE(1, 4)),
        'Résultat pour test ID ' || test_id || ', patient ' || v_patient_ids(p),
        v_base_date + MOD(test_id, 13),  -- Spread dates per test/competence
        test_id,
        v_patient_ids(p)
      );
    END LOOP;
  END LOOP;
END;

--remplissage de comprendre + evaluation
DECLARE
  CURSOR c_eval_groups IS
    SELECT 
      id_patient,
      date_test,
      COUNT(*) AS test_count
    FROM resultat_test_autisme
    GROUP BY id_patient, date_test
    HAVING COUNT(*) = 3;

  v_eval_id       NUMBER;
  v_praticien_id  NUMBER;
  v_centre_id     NUMBER;
BEGIN
  FOR eval_rec IN c_eval_groups LOOP
    -- Generate random IDs
    v_praticien_id := TRUNC(DBMS_RANDOM.VALUE(2, 8)); -- 2 to 7
    v_centre_id := TRUNC(DBMS_RANDOM.VALUE(2, 6));    -- 2 to 5

    -- Insert EVALUATION
    INSERT INTO evaluation (date_evaluation, id_praticien, id_centre)
    VALUES (eval_rec.date_test, v_praticien_id, v_centre_id)
    RETURNING id_evaluation INTO v_eval_id;

    -- Link the corresponding 3 RESULTAT_TEST_AUTISME rows
    FOR test_rec IN (
      SELECT id_resTest
      FROM resultat_test_autisme
      WHERE id_patient = eval_rec.id_patient
        AND date_test = eval_rec.date_test
    ) LOOP
      INSERT INTO comprendre (id_resTest, id_evaluation)
      VALUES (test_rec.id_resTest, v_eval_id);
    END LOOP;
  END LOOP;
END;
/



--remplissage de table resultat

DECLARE
  CURSOR c_resultats IS
    SELECT
      rta.id_patient,
      c.id_evaluation,
      FLOOR((rta.id_test - 6) / 3) + 1 AS id_competence,
      SUM(rta.score_brut) AS score_competence
    FROM comprendre c
    JOIN resultat_test_autisme rta ON c.id_restest = rta.id_restest
    GROUP BY rta.id_patient, c.id_evaluation, FLOOR((rta.id_test - 6) / 3);

  v_age_mental_calcule NUMBER;
BEGIN
  FOR rec IN c_resultats LOOP
    -- Optionally: generate a mental age between 2 and 10
    v_age_mental_calcule := TRUNC(DBMS_RANDOM.VALUE(2, 11));

    INSERT INTO resultat (
      score_competence,
      observation,
      age_mental_calcule,
      id_evaluation,
      id_patient,
      id_competence
    ) VALUES (
      rec.score_competence,
      'Observation automatique pour patient ' || rec.id_patient || ', compétence ' || rec.id_competence,
      v_age_mental_calcule,
      rec.id_evaluation,
      rec.id_patient,
      rec.id_competence
    );
  END LOOP;
END;



DECLARE
  CURSOR c_resultats IS
    SELECT
      rta.id_patient,
      c.id_evaluation,
      SUM(rta.score_brut) AS score_competence
    FROM comprendre c,competence com
    JOIN resultat_test_autisme rta ON c.id_restest = rta.id_restest 
    JOIN test t ON t.id_competence = com.id_competence
    GROUP BY rta.id_patient, c.id_evaluation, com.id_competence;

  v_age_mental_calcule NUMBER;
BEGIN
  FOR rec IN c_resultats LOOP
    -- Optionally: generate a mental age between 2 and 10
    v_age_mental_calcule := TRUNC(DBMS_RANDOM.VALUE(2, 11));

    INSERT INTO resultat (
      score_competence,
      observation,
      age_mental_calcule,
      id_evaluation,
      id_patient,
      id_competence
    ) VALUES (
      rec.score_competence,
      'Observation automatique pour patient ' || rec.id_patient || ', compétence ' || rec.id_competence,
      v_age_mental_calcule,
      rec.id_evaluation,
      rec.id_patient,
      com.id_competence
    );
  END LOOP;
END;

--remplissage de assiste a

BEGIN
  FOR patient_id IN (SELECT id_patient FROM patient) LOOP
    -- Randomly decide if the patient attends session 1
    IF DBMS_RANDOM.VALUE < 0.7 THEN  -- 70% chance
      INSERT INTO assiste_a (id_session, id_patient)
      VALUES (1, patient_id.id_patient);
    END IF;

    -- Randomly decide if the patient attends session 2
    IF DBMS_RANDOM.VALUE < 0.7 THEN
      INSERT INTO assiste_a (id_session, id_patient)
      VALUES (2, patient_id.id_patient);
    END IF;
  END LOOP;

  COMMIT;
END;


--remplissage de bilan annuelle

BEGIN
  FOR p IN (SELECT id_patient FROM patient) LOOP
    INSERT INTO bilan_annuelle (
      annee,
      synthese,
      progres_observes,
      id_patient
    ) VALUES (
      TRUNC(DBMS_RANDOM.VALUE(2022, 2026)),  -- Random year: 2022–2025
      'Synthèse générée automatiquement pour le patient ' || p.id_patient,
      'Progrès observés automatiquement pour le patient ' || p.id_patient,
      p.id_patient
    );
  END LOOP;

  COMMIT;
END;

--remplissage Historique

BEGIN
  FOR ev IN (SELECT id_evaluation, date_evaluation FROM evaluation) LOOP
    INSERT INTO historique (
      evenement,
      date_evenement,
      commentaire,
      id_evaluation
    ) VALUES (
      'Évaluation réalisée - ID ' || ev.id_evaluation,
      ev.date_evaluation,
      'Commentaire automatique pour l\'évaluation ' || ev.id_evaluation',
      ev.id_evaluation
    );
  END LOOP;

  COMMIT;
END;


--remplissage de plan_intervention

BEGIN
  FOR p IN (SELECT id_patient FROM patient) LOOP
    DECLARE
      v_date_creation   DATE := SYSDATE - TRUNC(DBMS_RANDOM.VALUE(30, 90));
      v_date_revision   DATE := v_date_creation + TRUNC(DBMS_RANDOM.VALUE(15, 60));
      v_statut          VARCHAR2(50);
      v_objectifs       CLOB := 'Objectifs préliminaires définis pour patient ' || p.id_patient;
      v_id_praticien    NUMBER := TRUNC(DBMS_RANDOM.VALUE(2, 8));  -- Assuming valid
      v_id_equipe       NUMBER;
    BEGIN
      -- Randomly choose a valid ID_EQUIPE
      SELECT id_equipe
      INTO v_id_equipe
      FROM (
        SELECT id_equipe FROM equipe ORDER BY DBMS_RANDOM.VALUE
      ) WHERE ROWNUM = 1;

      -- Randomly choose a status
      CASE TRUNC(DBMS_RANDOM.VALUE(1, 4))
        WHEN 1 THEN v_statut := 'En cours';
        WHEN 2 THEN v_statut := 'Terminé';
        WHEN 3 THEN v_statut := 'Suspendu';
      END CASE;

      INSERT INTO plan_intervention (
        date_creation,
        objectifs,
        statut,
        date_revision,
        id_patient,
        id_praticien,
        id_equipe
      ) VALUES (
        v_date_creation,
        v_objectifs,
        v_statut,
        v_date_revision,
        p.id_patient,
        v_id_praticien,
        v_id_equipe
      );
    END;
  END LOOP;

  COMMIT;
END;
/
