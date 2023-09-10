




/*Hernán Manuel Manrique Espíndola*/




CREATE TABLE CLIENTES (
    codigo_cliente number(3,0) PRIMARY KEY,
    nombre VARCHAR2(60) NOT NULL,
    apellido VARCHAR2(60) NOT NULL,
    fecha_nacimiento date NOT NULL,
    fecha_primera_vinculación date,
    email VARCHAR2(60) NOT NULL,
    genero char(1) NOT NULL
);


ALTER TABLE clientes
ADD CONSTRAINT rev_email
CHECK (REGEXP_LIKE(email,  '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'));

ALTER TABLE CLIENTES
ADD CONSTRAINT rev_genero
CHECK (GENERO IN ('F', 'f', 'M', 'm'));

CREATE TABLE OFICINAS(
    codigo_oficina number (3,0) PRIMARY KEY,
    nombre VARCHAR2(60) NOT NULL,
    presupuesto number(20,2) NOT NULL,
    horario_adicional char(1) NOT NULL
);

ALTER table OFICINAS
ADD CONSTRAINT rev_horario
CHECK (horario_adicional IN ('S', 's', 'N', 'n'));

CREATE TABLE CUENTAS(
    numero_cuenta number(3,0) PRIMARY KEY,
    tipo char(1) NOT NULL,
    codigo_oficina number (3,0) NOT NULL, 
    saldo number (20,2) DEFAULT NULL,
    FOREIGN KEY (codigo_oficina) REFERENCES OFICINAS (codigo_oficina)
);

ALTER table CUENTAS 
ADD CONSTRAINT rev_tipo
CHECK (tipo IN('C', 'c', 'A', 'a'));

create TABLE TITULARES(
    codigo_cliente number(3,0),
    numero_cuenta number(3,0),
    porcentaje_titularidad number (3,0) NOT NULL,
    PRIMARY KEY (codigo_cliente, numero_cuenta),
    FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES(codigo_cliente),
    FOREIGN KEY (numero_cuenta) REFERENCES CUENTAS(numero_cuenta)
);

CREATE TABLE PQRS(
    codigo_cliente NUMBER(3,0),
    numero NUMBER(2,0),
    tipo_queja char(1) NOT NULL,
    descripcion VARCHAR2(2000),
    PRIMARY KEY (codigo_cliente, numero),
    FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES(codigo_cliente)
);

ALTER table PQRS
ADD CONSTRAINT rev_tqueja
CHECK (tipo_queja IN ('P', 'Q', 'R', 'S', 'p', 'q', 'r', 's'));

CREATE TABLE MOVIMIENTOS(
    numero_cuenta NUMBER(3,0),
    numero number(3,0),
    tipo char(1) not null,
    naturaleza char(1) not null,
    valor NUMBER (10,2) not null,
    fecha_movimiento date not null,
    PRIMARY KEY (numero_cuenta, numero),
    FOREIGN KEY (numero_cuenta) REFERENCES CUENTAS(numero_cuenta)
);

ALTER table MOVIMIENTOS
ADD CONSTRAINT rev_mtipo
CHECK (tipo in('D', 'C', 'I', 'R', 'd', 'c', 'i', 'r'));

alter table MOVIMIENTOS
ADD CONSTRAINT rev_naturaleza
CHECK (naturaleza in('A', 'U', 'a', 'u'));


INSERT INTO CLIENTES VALUES (1, 'Pedro', 'Prerez', TO_DATE('01/01/1980', 'dd/mm/yyyy'), 
    TO_DATE('27/06/2000', 'dd/mm/yyyy'), 'Pedro@gmail.com', 'M');
INSERT INTO CLIENTES VALUES (2, 'Pedro', 'Prerez', TO_DATE('01/01/1999', 'dd/mm/yyyy'), 
    TO_DATE('12/06/2019', 'dd/mm/yyyy'), 'Prerez@gmail.com', 'm');
INSERT INTO CLIENTES VALUES (3, 'Maria', 'Restrepo', TO_DATE('03/04/1990', 'dd/mm/yyyy'), 
    TO_DATE('07/07/2011', 'dd/mm/yyyy'), 'MariaRe@gmail.com', 'f');
INSERT INTO CLIENTES VALUES (4, 'Juliana', 'Perez', TO_DATE('01/01/1975', 'dd/mm/yyyy'), 
    null , 'JuliPe@gmail.com', 'F');


INSERT INTO OFICINAS VALUES (1, 'Javeriana', 100000, 'N');
INSERT INTO OFICINAS VALUES (2, 'Madrid', 400000, 's');
INSERT INTO OFICINAS VALUES (3, 'Bilbao', 600000, 'N');

INSERT INTO CUENTAS VALUES(1, 'A', 2, 5000);
INSERT INTO CUENTAS VALUES(2, 'C', 1, 5000);
INSERT INTO CUENTAS VALUES(3, 'C', 2, 3000);
INSERT INTO CUENTAS VALUES(4, 'A', 1, 5000);

INSERT INTO TITULARES VALUES(1, 4, 100);
INSERT INTO TITULARES VALUES(4, 1, 100);
INSERT INTO TITULARES VALUES(2, 1, 100);
INSERT INTO TITULARES VALUES(1, 2, 100);
INSERT INTO TITULARES VALUES(4, 3, 100);


INSERT INTO PQRS VALUES(1, 1, 'P', 'Q');
INSERT INTO PQRS VALUES(2, 2, 'Q', 'R');
INSERT INTO PQRS VALUES(4, 3, 'R', 'S');

INSERT INTO MOVIMIENTOS VALUES(1, 10, 'D', 'U', 100000, TO_DATE('13/06/2020, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(1, 3, 'C', 'U', 50000, TO_DATE('12/09/2020, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(1, 1, 'I', 'A', 5000, TO_DATE('20/12/2021, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(1, 20, 'R', 'A', 120000, TO_DATE('30/12/2021, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));

INSERT INTO MOVIMIENTOS VALUES(2, 15, 'D', 'U', 500000, TO_DATE('20/08/2020, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(2, 2, 'C', 'U', 20000, TO_DATE('19/10/2020, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(2, 4, 'I', 'A', 2500, TO_DATE('23/12/2020, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(2, 7, 'R', 'U', 350000, TO_DATE('16/01/2022, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));

INSERT INTO MOVIMIENTOS VALUES(4, 9, 'D', 'A', 260000, TO_DATE('11/11/2020, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(4, 13, 'C', 'A', 30000, TO_DATE('01/03/2021, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(4, 21, 'I', 'A', 26000, TO_DATE('30/07/2021, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));
INSERT INTO MOVIMIENTOS VALUES(4, 30, 'R', 'A', 360000, TO_DATE('03/04/2022, 20:03:12', 'dd/MM/yyyy, hh24:mi:ss'));


/*  1  */
SELECT
    C.numero_cuenta AS "Número de Cuenta",
    C.tipo AS "Tipo de Cuenta",
    COALESCE(SUM(CASE WHEN M.tipo IN ('D', 'R') THEN M.valor ELSE 0 END), 0) AS "Debitos+Rendimientos",
    COALESCE(SUM(CASE WHEN M.tipo IN ('C', 'I') THEN M.valor ELSE 0 END), 0) AS "Creditos+Impuestos",
    COALESCE(SUM(CASE WHEN M.tipo IN ('D', 'R') THEN M.valor ELSE 0 END), 0) - COALESCE(SUM(CASE WHEN M.tipo IN ('C', 'I') THEN M.valor ELSE 0 END), 0) AS "Saldo",
    NULLIF(MIN(M.fecha_movimiento), TO_DATE('01/01/0001', 'dd/MM/yyyy')) AS "Fecha del Primer Movimiento",
    NULLIF(MAX(M.fecha_movimiento), TO_DATE('01/01/0001', 'dd/MM/yyyy')) AS "Fecha del Último Movimiento",
    (
        SELECT COUNT(*)
        FROM TITULARES T
        WHERE T.numero_cuenta = C.numero_cuenta
    ) AS "Cantidad de Titulares",
    O.nombre AS "Oficina"
FROM CUENTAS C
LEFT JOIN MOVIMIENTOS M ON C.numero_cuenta = M.numero_cuenta
INNER JOIN OFICINAS O ON C.codigo_oficina = O.codigo_oficina
GROUP BY GROUPING SETS ((C.numero_cuenta, C.tipo, O.nombre), ());


/*  2  */
WITH OfficeAccountData AS (
    SELECT
        O.nombre AS "Oficina",
        COUNT(DISTINCT CU.numero_cuenta) AS "Número de Cuentas en la Oficina",
        COUNT(DISTINCT CASE WHEN C.genero IN ('M', 'm') THEN T.codigo_cliente ELSE NULL END) AS "Número de Hombres con Cuenta",
        COUNT(DISTINCT CASE WHEN C.genero IN ('F', 'f') THEN T.codigo_cliente ELSE NULL END) AS "Número de Mujeres con Cuenta",
        AVG(CASE WHEN C.genero IN ('M', 'm') THEN CU.saldo ELSE NULL END) AS "Promedio de Saldos de Hombres con Cuenta",
        AVG(CASE WHEN C.genero IN ('F', 'f') THEN CU.saldo ELSE NULL END) AS "Promedio de Saldos de Mujeres con Cuenta"
    FROM
        OFICINAS O
    LEFT JOIN
        CUENTAS CU ON O.codigo_oficina = CU.codigo_oficina
    LEFT JOIN
        TITULARES T ON CU.numero_cuenta = T.numero_cuenta
    LEFT JOIN
        CLIENTES C ON T.codigo_cliente = C.codigo_cliente
    GROUP BY
        O.nombre
)
, OfficeMovementData AS (
    SELECT
        O.nombre AS "Oficina",
        COUNT(M.numero) AS "Número de Movimientos en la Oficina"
    FROM
        OFICINAS O
    LEFT JOIN
        CUENTAS CU ON O.codigo_oficina = CU.codigo_oficina
    LEFT JOIN
        MOVIMIENTOS M ON CU.numero_cuenta = M.numero_cuenta
    GROUP BY
        O.nombre
)
SELECT
    OA."Oficina",
    OA."Número de Cuentas en la Oficina",
    OA."Número de Hombres con Cuenta",
    OA."Número de Mujeres con Cuenta",
    OA."Promedio de Saldos de Hombres con Cuenta",
    OA."Promedio de Saldos de Mujeres con Cuenta",
    OM."Número de Movimientos en la Oficina"
FROM
    OfficeAccountData OA
LEFT JOIN
    OfficeMovementData OM ON OA."Oficina" = OM."Oficina"
UNION ALL
SELECT
    'Total' AS "Oficina",
    SUM("Número de Cuentas en la Oficina") AS "Número de Cuentas en la Oficina",
    SUM("Número de Hombres con Cuenta") AS "Número de Hombres con Cuenta",
    SUM("Número de Mujeres con Cuenta") AS "Número de Mujeres con Cuenta",
    NULL AS "Promedio de Saldos de Hombres con Cuenta",
    NULL AS "Promedio de Saldos de Mujeres con Cuenta",
    SUM("Número de Movimientos en la Oficina") AS "Número de Movimientos en la Oficina"
FROM
    OfficeAccountData OA
LEFT JOIN
    OfficeMovementData OM ON OA."Oficina" = OM."Oficina";



/*  3  */



WITH ClientAccountData AS (
    SELECT
        C.codigo_cliente,
        C.nombre || ' ' || C.apellido AS "Nombre Completo",
        LISTAGG(T1.numero_cuenta, ', ') WITHIN GROUP (ORDER BY T1.numero_cuenta) AS "Cuentas con 100% de Propiedad",
        COUNT(T1.numero_cuenta) AS "Cantidad de Cuentas con 100% de Propiedad",
        LISTAGG(T2.numero_cuenta, ', ') WITHIN GROUP (ORDER BY T2.numero_cuenta) AS "Cuentas con Propiedad Menor a 100%",
        COUNT(T2.numero_cuenta) AS "Cantidad de Cuentas con Propiedad Menor a 100%"
    FROM
        CLIENTES C
    LEFT JOIN
        TITULARES T1 ON C.codigo_cliente = T1.codigo_cliente AND T1.porcentaje_titularidad = 100
    LEFT JOIN
        TITULARES T2 ON C.codigo_cliente = T2.codigo_cliente AND T2.porcentaje_titularidad < 100
    GROUP BY
        C.codigo_cliente, C.nombre, C.apellido
)
, FirstMovementDate AS (
    SELECT
        T.codigo_cliente,
        MIN(M.fecha_movimiento) AS "Primera Fecha de Movimiento"
    FROM
        TITULARES T
    JOIN
        MOVIMIENTOS M ON T.numero_cuenta = M.numero_cuenta
    GROUP BY
        T.codigo_cliente
)
, ClientMovementCount AS (
    SELECT
        T.codigo_cliente,
        COUNT(M.numero) AS "Cantidad de Movimientos"
    FROM
        TITULARES T
    JOIN
        MOVIMIENTOS M ON T.numero_cuenta = M.numero_cuenta
    GROUP BY
        T.codigo_cliente
)
, MovementSum AS (
    SELECT
        T.codigo_cliente,
        SUM(CASE WHEN M.tipo = 'D' THEN M.valor ELSE 0 END) AS "Valor de Movimientos 'D' (Debito)",
        SUM(CASE WHEN M.tipo = 'C' THEN M.valor ELSE 0 END) AS "Valor de Movimientos 'C' (Credito)",
        SUM(CASE WHEN M.tipo = 'I' THEN M.valor ELSE 0 END) AS "Valor de Movimientos 'I' (Impuesto)",
        SUM(CASE WHEN M.tipo = 'R' THEN M.valor ELSE 0 END) AS "Valor de Movimientos 'R' (Rendimiento)"
    FROM
        TITULARES T
    JOIN
        MOVIMIENTOS M ON T.numero_cuenta = M.numero_cuenta
    GROUP BY
        T.codigo_cliente
)
SELECT
    CAD.codigo_cliente,
    CAD."Nombre Completo",
    CAD."Cuentas con 100% de Propiedad",
    CAD."Cantidad de Cuentas con 100% de Propiedad",
    CAD."Cuentas con Propiedad Menor a 100%",
    CAD."Cantidad de Cuentas con Propiedad Menor a 100%",
    FM."Primera Fecha de Movimiento",
    CMC."Cantidad de Movimientos",
    MS."Valor de Movimientos 'D' (Debito)",
    MS."Valor de Movimientos 'C' (Credito)",
    MS."Valor de Movimientos 'I' (Impuesto)",
    MS."Valor de Movimientos 'R' (Rendimiento)"
FROM
    ClientAccountData CAD
LEFT JOIN
    FirstMovementDate FM ON CAD.codigo_cliente = FM.codigo_cliente
LEFT JOIN
    ClientMovementCount CMC ON CAD.codigo_cliente = CMC.codigo_cliente
LEFT JOIN
    MovementSum MS ON CAD.codigo_cliente = MS.codigo_cliente;


/*  4  */

UPDATE CUENTAS C
SET saldo = (
    SELECT SUM(
        CASE
            WHEN M.tipo IN ('D', 'R') THEN M.valor
            ELSE 0
        END
    ) - SUM(
        CASE
            WHEN M.tipo IN ('C', 'I') THEN M.valor
            ELSE 0
        END
    )
    FROM MOVIMIENTOS M
    WHERE M.numero_cuenta = C.numero_cuenta
);


UPDATE CLIENTES C
SET C.fecha_primera_vinculación = (
    SELECT MIN(M.fecha_movimiento)
    FROM MOVIMIENTOS M
    WHERE M.numero_cuenta IN (
        SELECT numero_cuenta
        FROM TITULARES T
        WHERE T.codigo_cliente = C.codigo_cliente
    )
)
WHERE C.codigo_cliente IN (
    SELECT T.codigo_cliente
    FROM TITULARES T
);


/*  5  */

CREATE VIEW inconsistencias AS
SELECT
    O.nombre AS "Oficina",
    CU.numero_cuenta AS "Código de la Cuenta",
    LISTAGG(CL.nombre || ' ' || CL.apellido, '; ') WITHIN GROUP (ORDER BY CL.codigo_cliente) AS "Nombres de Titulares",
    LISTAGG(T.porcentaje_titularidad, '; ') WITHIN GROUP (ORDER BY CL.codigo_cliente) AS "Porcentajes de Titulares",
    SUM(T.porcentaje_titularidad) AS "Suma de Porcentajes"
FROM
    OFICINAS O
JOIN
    CUENTAS CU ON O.codigo_oficina = CU.codigo_oficina
JOIN
    TITULARES T ON CU.numero_cuenta = T.numero_cuenta
JOIN
    CLIENTES CL ON T.codigo_cliente = CL.codigo_cliente
GROUP BY
    O.nombre, CU.numero_cuenta
HAVING
    SUM(T.porcentaje_titularidad) != 100;

SELECT * FROM inconsistencias;






drop view inconsistencias;
drop table MOVIMIENTOS;
drop table PQRS;
drop table TITULARES;
drop table CUENTAS;
drop table OFICINAS;
drop table clientes;

