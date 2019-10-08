DROP TABLE Aimer CASCADE CONSTRAINTS;
DROP TABLE Appartenir CASCADE CONSTRAINTS;
DROP TABLE EnCouple CASCADE CONSTRAINTS;
DROP TABLE EtreAmis CASCADE CONSTRAINTS;
DROP TABLE Groupes CASCADE CONSTRAINTS;
DROP TABLE Messages CASCADE CONSTRAINTS;
DROP TABLE Pages CASCADE CONSTRAINTS;
DROP TABLE Pays CASCADE CONSTRAINTS;
DROP TABLE Publications CASCADE CONSTRAINTS;
DROP TABLE Statuts CASCADE CONSTRAINTS;
DROP TABLE Utilisateurs CASCADE CONSTRAINTS;
DROP TABLE Villes CASCADE CONSTRAINTS;

CREATE TABLE Groupes (
  idGroupe number(11) NOT NULL,
  nomGroupe varchar2(45) NOT NULL,
  PRIMARY KEY (idGroupe)
);

CREATE TABLE Pays (
  nomPays varchar2(30) NOT NULL,
  PRIMARY KEY (nomPays)
);

CREATE TABLE Villes (
  idVilles number(11) NOT NULL,
  nomVille varchar2(45) NOT NULL,
  nomPays varchar2(30) NOT NULL,
  PRIMARY KEY (idVilles),
  FOREIGN KEY (nomPays) REFERENCES Pays (nomPays)
);


CREATE TABLE Statuts (
  prive varchar2(5) NOT NULL,
  publique varchar2(5) NOT NULL,
  PRIMARY KEY (prive, publique)
);

CREATE TABLE Utilisateurs (
  pseudo varchar2(45) NOT NULL,
  nom varchar2(45) NOT NULL,
  email varchar2(45) NOT NULL,
  prenom varchar2(45) NOT NULL,
  motDePass varchar2(45) NOT NULL,
  telephone varchar2(45) NOT NULL,
  dateNaissance date NOT NULL,
  sexe varchar2(1) NOT NULL,
  dateInscription date NOT NULL,
  dateFermeture date DEFAULT NULL,
  idVilles number(11) NOT NULL,
  PRIMARY KEY (pseudo),
  FOREIGN KEY (idVilles) REFERENCES Villes (idVilles)
);

CREATE TABLE Pages (
  idPages number(11) NOT NULL,
  nomPage varchar2(45) NOT NULL,
  pseudo varchar2(45) NOT NULL,
  prive varchar2(5) NOT NULL,
  publique varchar2(5) NOT NULL,
  idGroupe number(11) NOT NULL,
  PRIMARY KEY (idPages),
  FOREIGN KEY (pseudo) REFERENCES Utilisateurs (pseudo),
  FOREIGN KEY (prive, publique) REFERENCES Statuts (prive, publique),
  --FOREIGN KEY (publique) REFERENCES Statuts (publique),
  FOREIGN KEY (idGroupe) REFERENCES Groupes (idGroupe)
);

CREATE TABLE Appartenir (
  idGroupe number(11) NOT NULL,
  pseudo varchar2(45) NOT NULL,
  PRIMARY KEY (idGroupe,pseudo),
  FOREIGN KEY (idGroupe) REFERENCES Groupes (idGroupe),
  FOREIGN KEY (pseudo) REFERENCES Utilisateurs (pseudo)
);

CREATE TABLE Publications (
  idPublications number(11) NOT NULL,
  titre varchar2(45) NOT NULL,
  datePublication varchar2(45) NOT NULL,
  texte varchar2(1500) NOT NULL,
  nombreAime varchar2(45) DEFAULT NULL,
  idPages number(11) NOT NULL,
  idPublications2 number(11) NOT NULL,
  pseudo varchar2(45) NOT NULL,
  PRIMARY KEY (idPublications),
  FOREIGN KEY (idPages) REFERENCES Pages (idPages),
  FOREIGN KEY (idPublications2) REFERENCES Publications (idPublications),
  FOREIGN KEY (pseudo) REFERENCES Utilisateurs (pseudo)
);


CREATE TABLE Aimer (
  pseudo varchar2(45) NOT NULL,
  idPages number(11) NOT NULL,
  idPublications number(11) NOT NULL, 
  PRIMARY KEY (pseudo,idPages,idPublications),
  FOREIGN KEY (pseudo) REFERENCES Utilisateurs (pseudo),
  FOREIGN KEY (idPages) REFERENCES Pages (idPages),
  FOREIGN KEY (idPublications) REFERENCES Publications (idPublications)
);

CREATE TABLE EnCouple (
  pseudo1 varchar2(45) NOT NULL,
  pseudo2 varchar2(45) NOT NULL,
  dateUnion date NOT NULL,
  PRIMARY KEY (pseudo1, pseudo2),
  FOREIGN KEY (pseudo1) REFERENCES Utilisateurs (pseudo),
  FOREIGN KEY (pseudo2) REFERENCES Utilisateurs (pseudo)
);

CREATE TABLE EtreAmis (
  pseudo1 varchar2(45) NOT NULL,
  pseudo2 varchar2(45) NOT NULL,
  dateDebutAmitie date NOT NULL,
  PRIMARY KEY (pseudo1, pseudo2),
  FOREIGN KEY (pseudo1) REFERENCES Utilisateurs (pseudo),
  FOREIGN KEY (pseudo2) REFERENCES Utilisateurs (pseudo)  
);

CREATE TABLE Messages (
  idMessages number(11) NOT NULL,
  titre varchar2(45) NOT NULL,
  texte varchar2(45) NOT NULL,
  dateEnvoi varchar2(45) NOT NULL,
  pseudoExpediteur varchar2(45) NOT NULL,
  pseudoRecepteur varchar2(45) NOT NULL,
  idGroupe number(11) NOT NULL,
  idMessagesParent number(11) NOT NULL,
  PRIMARY KEY (idMessages),
  FOREIGN KEY (idGroupe) REFERENCES Groupes (idGroupe),
  FOREIGN KEY (idMessagesParent) REFERENCES Messages (idMessages),
  FOREIGN KEY (pseudoExpediteur) REFERENCES Utilisateurs (pseudo),
  FOREIGN KEY (pseudoRecepteur) REFERENCES Utilisateurs (pseudo)
);

