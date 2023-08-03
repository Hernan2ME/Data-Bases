drop table Materia_X_Estudiante;
drop table Materia_X_Departamento;
drop table Estudiantez;
drop table Materias;
drop table Departamento;


Create table Estudiantez(
    codigo_es number(8,0),
    nombre varchar2 (100) not null,
    apellido varchar2 (100) not null,
    telefono number (10,0),
    primary key (codigo_es)
);

create table Materias(
    codigo_ma number (3,0),
    nombre varchar2 (100) not null,
    primary key (codigo_ma)
);

create table Departamento(
    codigo_dep number (4,0),
    nombre varchar2 (100) not null,
    primary key (codigo_dep)
);

create table Materia_X_Estudiante(
    CodigoEstudiante number (8,0),
    CodigoMateria number (3,0),
    primary key (CodigoEstudiante, CodigoMateria),
    foreign key (CodigoEstudiante) references Estudiantez,
    foreign key (CodigoMateria) references Materias
);

create table Materia_X_Departamento(
    CodigoMateria number (8,0),
    CodigoDepartamento number (5,0),
    primary key (CodigoMateria, CodigoDepartamento),
    foreign key (CodigoMateria) references Materias,
    foreign key (CodigoDepartamento) references Departamento
);

insert into Estudiantez values (1, 'DAVID', 'OSPINA', null );
insert into Estudiantez values (2, 'JUAN', 'CUADRADO', null );
insert into Estudiantez values (3, 'MARIA', 'MENDOZA', null );
insert into Estudiantez values (4, 'MIGUEL', 'CERVANTES', null);
insert into Estudiantez values (5, 'MIGUEL', 'INDURAIN', null);
insert into Estudiantez values (6, 'DAVID', 'OSPINA', null);

insert into Materias values (100, 'CALCULO I');
insert into Materias values (200, 'REDACCION');
insert into Materias values (300, 'FISICA I');
insert into Materias values (400, 'FISICA II');
insert into Materias values (500, 'CIRCIUTOS ELECTRICOS');

insert into Departamento values (1000, 'SISTEMAS');
insert into Departamento values (2000, 'ELECTRONICA');
insert into Departamento values (3000, 'CIENCIA DE DATOS');
insert into Departamento values (4000, 'MATEMATICAS');
insert into Departamento values (5000, 'LETRAS');
insert into Departamento values (6000, 'FISICA');
insert into Departamento values (7000, 'QUIMICA');

insert into Materia_X_Estudiante values (1, 100);
insert into Materia_X_Estudiante values (1, 300);
insert into Materia_X_Estudiante values (2, 100);
insert into Materia_X_Estudiante values (2, 300);
insert into Materia_X_Estudiante values (3, 200);
insert into Materia_X_Estudiante values (4, 200);
insert into Materia_X_Estudiante values (5, 100);

insert into Materia_X_Departamento values (100,4000);
insert into Materia_X_Departamento values (500,2000);
insert into Materia_X_Departamento values (500,1000);
insert into Materia_X_Departamento values (200,5000);
insert into Materia_X_Departamento values (300,6000);
insert into Materia_X_Departamento values (400,6000);


