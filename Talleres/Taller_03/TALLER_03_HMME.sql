/* TALLER 03 BASES DE DATOS*/

/*Hernán Manuel MAnrique Espíndola*/


/* Eliminación de las tablas*/
DROP table DetalleFactura;
DROP table Factura;
DROP table producto;
DROP table persona;



/*CREACIÓN DE LAS TABLAS*/
/*Tabla Producto*/
CREATE TABLE producto(
    codigoProducto number(3,0) PRIMARY KEY,
    nombreProducto VARCHAR2(60) not null,
    valorUnitario number(8,2) not null
);

/*Tabla Personas*/
CREATE TABLE persona(
    tipoDocumento VARCHAR2(2),
    Documento number(6,0),
    Nombre VARCHAR2(60) not null,
    Apellido VARCHAR2(60) not null,
    fechaNacimiento VARCHAR2(60),
    Genero VARCHAR2(1),
    Peso number(5,0),
    Estatura number(5,2),
    PRIMARY KEY (tipoDocumento, Documento)
);

/*Tabla factura*/
CREATE TABLE Factura(
    codigoFactura VARCHAR2(3) PRIMARY KEY,
    fechaFactrua VARCHAR2(60),
    tipoDocumento VARCHAR2(2),
    Documento number(6,0),
    fechaEntrega VARCHAR2(60),
    FOREIGN KEY (tipoDocumento, Documento) references persona (tipoDocumento, Documento)
);

/*Tabla Detalles Facturas*/
CREATE TABLE DetalleFactura(
    codigoFactura VARCHAR2(3),
    lineaFactura number(3,0),
    codigoProducto number(3,0),
    Cantidad number(6,0),
    PRIMARY KEY (codigoFactura, lineaFactura),
    FOREIGN KEY (codigoFactura) references Factura (codigoFactura),
    FOREIGN KEY (codigoProducto) references producto (codigoProducto)
);


/*INSERCIÓN DE INFORMACIÓN*/

/*Inserción en la tabla productos*/
INSERT INTO producto VALUES (1, 'Laptop', 2000);
INSERT INTO producto VALUES (2, 'Mouse', 50);
INSERT INTO producto VALUES (3, 'Tablet', 60);

/*Inserción en la tabla personas*/
ALTER SESSION SET NLS_LANGUAGE = 'SPANISH';

INSERT INTO persona VALUES ('CC', 1, 'Pedro', 'Perez', 
    TO_CHAR(TO_DATE('01/01/1980', 'dd/mm/yyyy'), 'Month DD "de" YYYY'), 'M', 70, 170);
INSERT INTO persona VALUES ('CE', 1, 'Juan', 'Perez', 
    TO_CHAR(TO_DATE('30/01/1981', 'dd/mm/yyyy'), 'Month DD "de" YYYY'), 'M', 80, 180);
INSERT INTO persona VALUES ('CC', 2, 'Maria', 'Perez', 
    TO_CHAR(TO_DATE('12/02/1979', 'dd/mm/yyyy'), 'Month DD "de" YYYY'), 'F', 50, 158);
INSERT INTO persona VALUES ('CC', 33, 'Laura', 'Resptrepo', 
    TO_CHAR(TO_DATE('30/11/1960', 'dd/mm/yyyy'), 'Month DD "de" YYYY'), 'F', 52, 160);
INSERT INTO persona VALUES ('CE', 100, 'Pedro', 'Perez', 
    TO_CHAR(TO_DATE('30/01/1982', 'dd/mm/yyyy'), 'Month DD "de" YYYY'), 'm', 80, 180);

/*Inserción en la tabla Facturas*/
INSERT INTO Factura VALUES ('F1', TO_CHAR(TO_DATE('06/02/2017', 'dd/mm/yyyy'), 'DD Month YYYY'), 'CC', 1, 
    TO_CHAR(TO_DATE('06/02/2017', 'dd/mm/yyyy'), 'DD Month YYYY'));
INSERT INTO Factura VALUES ('F3', TO_CHAR(TO_DATE('06/02/2017', 'dd/mm/yyyy'), 'DD Month YYYY'), 'CC', 2, 
    TO_CHAR(TO_DATE('06/03/2017', 'dd/mm/yyyy'), 'DD Month YYYY'));
INSERT INTO Factura VALUES ('F4', TO_CHAR(TO_DATE('05/02/2016', 'dd/mm/yyyy'), 'DD Month YYYY'), 'CC', 33, null);

/*Inserción en la tabla Detalles Facturas*/
INSERT INTO DetalleFactura VALUES ('F1', 1, 1, 100);
INSERT INTO DetalleFactura VALUES ('F1', 2, 2, 5);
INSERT INTO DetalleFactura VALUES ('F1', 3, 3, 100);
INSERT INTO DetalleFactura VALUES ('F3', 1, 1, 1);
INSERT INTO DetalleFactura VALUES ('F3', 2, 2, 5000);
INSERT INTO DetalleFactura VALUES ('F3', 3, 2, 5000);
INSERT INTO DetalleFactura VALUES ('F4', 1, 2, 10000);
INSERT INTO DetalleFactura VALUES ('F4', 2, 2, 10000);
INSERT INTO DetalleFactura VALUES ('F4', 3, 2, 10000);



/*SOLUCION DE PROBLEMAS*/
    
/* 1. Cual es la mujer y el hombre (Nombres y Apellidos en un campo llamado
Nombre Completo) con la factura de más valor (En pesos), siempre y cuando la
factura haya sido entregada. Mostrar Nombre Completo y valor de la factura.*/

SELECT
    p.Nombre || ' ' || p.Apellido AS "Nombre Completo",
    f.codigoFactura AS "Numero factura",
    MAX(df.valorTotal) AS "Valor de la Factura",
    p.Genero AS "Genero"
FROM
    persona p
JOIN
    (
        SELECT
            f.tipoDocumento,
            f.Documento,
            f.codigoFactura,
            SUM(df.Cantidad * pr.valorUnitario) AS valorTotal
        FROM
            Factura f
        JOIN
            DetalleFactura df ON f.codigoFactura = df.codigoFactura
        JOIN
            producto pr ON df.codigoProducto = pr.codigoProducto
        WHERE
            f.fechaEntrega IS NOT NULL
        GROUP BY
            f.tipoDocumento, f.Documento, f.codigoFactura
    ) df ON p.tipoDocumento = df.tipoDocumento AND p.Documento = df.Documento
JOIN
    Factura f ON df.codigoFactura = f.codigoFactura
WHERE
    p.Genero = 'F' OR p.Genero = 'M'
GROUP BY
    p.Nombre, p.Apellido, p.Genero, f.codigoFactura
HAVING
    MAX(df.valorTotal) IS NOT NULL;



/*2. Cual es la factura (Codigo Factura, fecha de factura, persona(nombres y
apellidos) ), con la mayor cantidad de artículos vendidos (en total).*/

SELECT
    f.codigoFactura AS "Codigo Factura",
    f.fechaFactrua AS "Fecha de Factura",
    p.Nombre || ' ' || p.Apellido AS "Nombre Completo",
    SUM(df.Cantidad) AS "Cantidad de artículos"
FROM
    Factura f
JOIN
    DetalleFactura df ON f.codigoFactura = df.codigoFactura
JOIN
    persona p ON f.tipoDocumento = p.tipoDocumento AND f.Documento = p.Documento
GROUP BY
    f.codigoFactura, f.fechaFactrua, p.Nombre, p.Apellido
ORDER BY
    SUM(df.Cantidad) DESC
FETCH FIRST 1 ROW ONLY;


/*3. Que cliente (Nombres y Apellidos) ha comprado todos los productos (No
necesariamente en la misma factura) .*/

WITH TotalProductos AS (
    SELECT COUNT(*) AS total_productos FROM producto
),
ProductosComprados AS (
    SELECT
        f.tipoDocumento,
        f.Documento,
        COUNT(DISTINCT df.codigoProducto) AS productos_comprados
    FROM
        Factura f
    JOIN
        DetalleFactura df ON f.codigoFactura = df.codigoFactura
    GROUP BY
        f.tipoDocumento, f.Documento
)
SELECT
    p.tipoDocumento AS "Tipo de Documento",
    p.Documento AS "Numero de Documento",
    p.Nombre || ' ' || p.Apellido AS "Cliente"
FROM
    persona p
JOIN
    ProductosComprados pc ON p.tipoDocumento = pc.tipoDocumento AND p.Documento = pc.Documento
CROSS JOIN
    TotalProductos tp
WHERE
    pc.productos_comprados = tp.total_productos;

/*4. Mostrar un listado*/

SELECT
    f.codigoFactura AS "Factura",
    SUM(df.Cantidad * pr.valorUnitario) AS "Valor Factura",
    COUNT(DISTINCT df.codigoProducto) AS "Numero de articulos diferentes",
    p.Nombre || ' ' || p.Apellido AS "Persona",
    f.fechaFactrua AS "Fecha factura"
FROM
    Factura f
JOIN
    DetalleFactura df ON f.codigoFactura = df.codigoFactura
JOIN
    persona p ON f.tipoDocumento = p.tipoDocumento AND f.Documento = p.Documento
JOIN
    producto pr ON df.codigoProducto = pr.codigoProducto
GROUP BY
    f.codigoFactura, p.Nombre, p.Apellido, f.fechaFactrua
ORDER BY
    "Valor Factura" DESC;

/*5. Cual es la factura en la que se tuvo el mayor retraso en la entrega, mostrar
Codigo de la factura, cantidad de productos, y fecha factura, fecha de entrega,
Dias de demora en entrega (Los días de demora en entrega se definen como
los días transcurridos entre la fecha de entrega y la fecha de factura).*/

SELECT
    f.codigoFactura AS "Codigo de la factura",
    COUNT(df.codigoFactura) AS "Cantidad de productos",
    TO_CHAR(TO_DATE(f.fechaFactrua, 'DD/MM/YYYY'), 'DD Month YYYY') AS "Fecha factura",
    TO_CHAR(TO_DATE(f.fechaEntrega, 'DD/MM/YYYY'), 'DD Month YYYY') AS "Fecha de entrega",
    (TO_DATE(f.fechaEntrega, 'DD/MM/YYYY') - TO_DATE(f.fechaFactrua, 'DD/MM/YYYY')) AS "Dias de demora en entrega"
FROM
    Factura f
JOIN
    DetalleFactura df ON f.codigoFactura = df.codigoFactura
WHERE
    f.fechaEntrega IS NOT NULL
GROUP BY
    f.codigoFactura, f.fechaFactrua, f.fechaEntrega
ORDER BY
    "Dias de demora en entrega" DESC
FETCH FIRST 1 ROW ONLY;

/*6. Mostrar un listado de los clientes de la siguiente manera (los clientes que no
han comprado ningun artículo debe salir en la respuesta*/

SELECT
    p.tipoDocumento AS Tipo_Documento,
    p.Documento,
    p.Nombre || ' ' || p.Apellido AS Nombre_Completo,
    COUNT(DISTINCT df.codigoProducto) AS Num_Productos_Comprados
FROM
    persona p
    LEFT JOIN Factura f ON p.tipoDocumento = f.tipoDocumento AND p.Documento = f.Documento
    LEFT JOIN DetalleFactura df ON f.codigoFactura = df.codigoFactura
GROUP BY
    p.tipoDocumento,
    p.Documento,
    p.Nombre,
    p.Apellido
HAVING
    COUNT(DISTINCT df.codigoProducto) > 0 OR COUNT(f.codigoFactura) = 0
ORDER BY
    p.tipoDocumento,
    p.Documento;
