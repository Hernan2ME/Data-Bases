/*TALLER 02 BASES DE DATOS /*

/* -Hernán Manuel Manrique Espíndola */





DROP table Autores_X_Libro; /* Eliminación de la tabla Autores_X_Libro */
DROP table Libro; /* Eliminación de la tabla Libro */
DROP TABLE Autor; /* Eliminación de la tabla Autor */
DROP TABLE PAIS; /* Eliminación de la tabla País */
DROP TABLE Genero; /* Eliminación de la tabla Género */

/* Creación de la tabla País */
CREATE TABLE PAIS(
    coidgoPais number (3,0),
    nombrePais VARCHAR2(60) not null,
    primary key(coidgoPais)
);

/* Creación de la tabla Género */
CREATE TABLE Genero(
    codigoGenero number (3,0),
    nombreGenero VARCHAR2(60) not null,
    primary key(codigoGenero)
);

/* Creación de la tabla Autor */
CREATE TABLE Autor(
    codigoAutor number (3,0),
    Nombres VARCHAR2(60) not null,
    Apellidos VARCHAR2(60) not null,
    fechaNacimiento DATE,
    fechaFallecimiento DATE,
    paisNacimiento number(3,0),
    PRIMARY KEY (codigoAutor),
    FOREIGN key (paisNacimiento) REFERENCES PAIS (coidgoPais)
);

/* Creación de la tabla Libro */
CREATE TABLE Libro(
    codigoISBM VARCHAR2(15),
    Nombre varchar2(100),
    codigoGenero number (3,0),
    numeroPaginas number (5,0),
    Primary Key (codigoISBM),
    FOREIGN Key (codigoGenero) references Genero (codigoGenero)
);

/* Creación de la tabla Autores_X_Libro */
CREATE TABLE Autores_X_Libro(
    codigoAutor  number(3,0) not null,
    codigoISBM VARCHAR2(15) not null,
    primary key (codigoAutor, codigoISBM),
    FOREIGN key (codigoAutor) references Autor (codigoAutor),
    FOREIGN key (codigoISBM) references Libro (codigoISBM)
);
 
/* Inserción de información en la tabla País */
INSERT into PAIS VALUES (1, 'Estados Unidos');
INSERT into PAIS VALUES (2, 'Japon');
INSERT into PAIS VALUES (3, 'Israel');
INSERT into PAIS VALUES (4, 'Reino Unido');
INSERT into PAIS VALUES (5, 'Italia');
INSERT into PAIS VALUES (6, 'India');
INSERT INTO PAIS VALUES (7, 'Colombia');

/* Inserción de información en la tabla Género */
INSERT INTO Genero VALUES (1, 'Acción');
INSERT INTO Genero VALUES (2, 'Tecnología');
INSERT INTO Genero VALUES (3, 'Suspenso');
INSERT INTO Genero VALUES (4, 'Epica');
INSERT INTO Genero VALUES (5, 'Poesía Epica');
INSERT INTO Genero VALUES (6, 'Ficción');
INSERT INTO Genero VALUES (7, 'Fantasía');

/* Inserción de información en la tabla Autor */
INSERT INTO Autor VALUES (1, 'John', 'Katzenbach', TO_DATE('23/06/1950', 'dd/mm/yyyy'),null , 1);
INSERT INTO Autor VALUES (2, 'Avi', 'Silverschat', TO_DATE('1/05/1947', 'dd/mm/yyyy'),null , 3);
INSERT INTO Autor VALUES (3, 'Henry', 'F. Korth', TO_DATE('23/06/1950', 'dd/mm/yyyy'),null , 1);
INSERT INTO Autor VALUES (4, 'S.', 'Sudarshan', TO_DATE('12/07/1961', 'dd/mm/yyyy'),null , 6);
INSERT INTO Autor VALUES (5, 'John', 'Grisham', TO_DATE('08/02/1955', 'dd/mm/yyyy'),null , 1);
INSERT INTO Autor VALUES (6, 'John', 'Milton', TO_DATE('9/12/1608', 'dd/mm/yyyy'),TO_DATE('8/11/1674', 'dd/mm/yyyy') , 4);
INSERT INTO Autor VALUES (7, 'Dante', 'Alighieri', TO_DATE('29/05/1265', 'dd/mm/yyyy'),TO_DATE('14/09/1321', 'dd/mm/yyyy') , 5);
INSERT INTO Autor VALUES (8, 'Michael', 'Milton', TO_DATE('23/06/1950', 'dd/mm/yyyy'),null , 1);
INSERT INTO Autor VALUES (9, 'Isuna', 'Hasekura', TO_DATE('17/12/1982', 'dd/mm/yyyy'),null , 2);
INSERT INTO Autor VALUES (10, 'Rei', 'Kawahara', TO_DATE('17/08/1974', 'dd/mm/yyyy'),null , 2);
INSERT INTO AUTOR VALUES (11, 'Ricardo', 'Silva Romero', TO_DATE('14/08/1975', 'dd/mm/yyyy'), null, 7);

/* Inserción de información en la tabla Libro */
INSERT INTO LIBRO VALUES ('9788498724356','El_Psicoanalista', 1, 464);
INSERT INTO LIBRO VALUES ('0073523321','Database System Concepts', 2, 1376);
INSERT INTO LIBRO VALUES ('9788483468784','El Socio %', 3, 480);
INSERT INTO LIBRO VALUES ('9788466655002','El Estudiante', 3, 472);
INSERT INTO LIBRO VALUES ('9788467027198','El Paraiso Perdido', 4, 402);
INSERT INTO LIBRO VALUES ('9788889352311','La Divina Comedia', 5, 274);
INSERT INTO LIBRO VALUES ('9780596153939','Head First Data Analysis: A learner´s guide to big numbers, statistics and good decisions', 2, 483);
INSERT INTO LIBRO VALUES ('9780759531048','Spice and Wolf Vol. 1', 7, 234);
INSERT INTO LIBRO VALUES ('9780316371247','Sword Art Online Vol. 1', 6, 256);

/* Inserción de información en la tabbla Autores_X_Libro */
INSERT INTO AUTORES_X_LIBRO VALUES (1, '9788498724356');
INSERT INTO AUTORES_X_LIBRO VALUES (2, '0073523321');
INSERT INTO AUTORES_X_LIBRO VALUES (3, '0073523321');
INSERT INTO AUTORES_X_LIBRO VALUES (4, '0073523321');
INSERT INTO AUTORES_X_LIBRO VALUES (5, '9788483468784');
INSERT INTO AUTORES_X_LIBRO VALUES (1, '9788466655002');
INSERT INTO AUTORES_X_LIBRO VALUES (6, '9788467027198');
INSERT INTO AUTORES_X_LIBRO VALUES (7, '9788889352311');
INSERT INTO AUTORES_X_LIBRO VALUES (8, '9780596153939');
INSERT INTO AUTORES_X_LIBRO VALUES (9, '9780759531048');
INSERT INTO AUTORES_X_LIBRO VALUES (10, '9780316371247');

/* Listado de autores y libros escritos */
SELECT  a.NOMBRES || ' ' || A.APELLIDOS as AUTOR, COUNT(L.CODIGOISBM) as Numero_Libros_Publicados
FROM AUTOR a
left join AUTORES_X_LIBRO AxL on a.CODIGOAUTOR = AxL.CODIGOAUTOR
left join LIBRO L on AxL.CODIGOISBM = L.CODIGOISBM
group by a.CODIGOAUTOR, a.NOMBRES, a.APELLIDOS;

/* Numero de libros publicados por genero */
SELECT g.nombreGenero as GENERO, COUNT(L.codigoISBM) as Numero_Libros_Publicados
from GENERO g, LIBRO L
WHERE g.CODIGOGENERO = L.CODIGOGENERO
group by g.NOMBREGENERO;

/* Libros que contienen ' % ' o ' _ ' en el titulo */
SELECT L.nombre as LIBRO, a.NOMBRES || ' ' || a.APELLIDOS as AUTOR, p.NOMBREPAIS as PAIS, g.NOMBREGENERO as GENERO
FROM LIBRO L
left join AUTORES_X_LIBRO AxL on L.CODIGOISBM = AxL.CODIGOISBM
left join AUTOR a on AXL.CODIGOAUTOR = a.CODIGOAUTOR
left join GENERO g on L.CODIGOGENERO = g.CODIGOGENERO
left join PAIS p on a.PAISNACIMIENTO = p.COIDGOPAIS
where UPPER(L.NOMBRE) LIKE '%\%%' ESCAPE '\'
or UPPER(L.NOMBRE) like '%\_%' ESCAPE '\';

