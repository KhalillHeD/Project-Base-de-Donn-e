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