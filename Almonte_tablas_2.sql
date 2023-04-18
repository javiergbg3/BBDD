
DROP TABLE IF EXISTS Persona;

DROP TABLE IF EXISTS Tiene;

DROP TABLE IF EXISTS Item;

DROP TABLE IF EXISTS Instalacion;

DROP TABLE IF EXISTS Proveedor;


-- Creación de tabla Proveedor
CREATE TABLE Proveedor (
    nombre          VARCHAR(50) PRIMARY KEY,
    telefono        VARCHAR(20) NOT NULL
);

-- Creación de tabla Instalacion
CREATE TABLE Instalacion(
    id_instalacion  SERIAL PRIMARY KEY,
    direccion       VARCHAR(100) NOT NULL,
    telefono        VARCHAR(20) NOT NULL,
    mantenimiento   INTEGER NOT NULL
);

-- Creación de tabla Item
CREATE TABLE Item (
    id_item         SERIAL PRIMARY KEY,
    nombre          VARCHAR(30) NOT NULL,
    precio          INTEGER NOT NULL,
    tipo            VARCHAR(30) NOT NULL,
    proveedor_id    VARCHAR(50) REFERENCES Proveedor(nombre)
);

-- Creación de tabla Tiene
CREATE TABLE Tiene (
    id_producto            REFERENCES Item(id_item),
    id_establecimiento     REFERENCES Instalacion(id_instalacion),
    PRIMARY KEY (id_producto, id_establecimiento)
);

-- Creación de tabla Persona
CREATE TABLE Persona (
    id_persona              SERIAL PRIMARY KEY,
    DNI                     VARCHAR(9),
    lugar_trabajo           REFERENCES Instalacion(id_instalacion),
    nombre                  VARCHAR(30) NOT NULL,
    correo                  VARCHAR(30) NOT NULL,
    telefono                VARCHAR(20) NOT NULL,
    numero_socio            INTEGER,
    puntos_acumulados       INTEGER,
    cargo                   VARCHAR(30),
    nomina                  INTEGER