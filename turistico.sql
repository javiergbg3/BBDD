CREATE OR REPLACE TYPE ClienteUDT AS OBJECT (
    id NUMBER,
    nombre VARCHAR2(20),
    apellidos VARCHAR2(20),
    telefono NUMBER,
    compras REF(CompraUDT) ARRAY,
    MEMBER FUNCTION calcularPrecio(p IN PaqueteUDT) RETURN NUMBER
);

CREATE OR REPLACE TYPE CompraUDT AS OBJECT (
    id NUMBER,
    personas NUMBER,
    cliente REF ClienteUDT,
    paquete REF PaqueteUDT,
    MEMBER FUNCTION calcularPrecio(p IN PaqueteUDT) RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY CompraUDT AS
    MEMBER FUNCTION calcularPrecio(p IN PaqueteUDT) RETURN NUMBER IS
        Total NUMBER := 0;
    BEGIN
        FOR i IN 1..p.pertenece.COUNT LOOP
            Total := Total + p.pertenece(i).precio;
        END LOOP;
        RETURN Total;
    END;
END;

CREATE OR REPLACE TYPE PaqueteUDT AS OBJECT (
    id NUMBER,
    ciudad VARCHAR2(20),
    compras REF(CompraUDT) ARRAY,
    pertenece REF(PerteneceUDT) ARRAY
);

CREATE OR REPLACE TYPE PerteneceUDT AS OBJECT (
    precio NUMBER,
    paquete REF(PaqueteUDT),
    servicio REF(ServicioUDT)
);

CREATE OR REPLACE TYPE ServicioUDT AS OBJECT (
    id NUMBER,
    precio_actual NUMBER,
    pertenece REF(PerteneceUDT)
);

CREATE OR REPLACE TYPE MonumentoUDT UNDER ServicioUDT (
    NombreMonumento VARCHAR2(20),
    Descripcion VARCHAR2(200),
    HoraInicio DATE,
    HoraFinal DATE,
    Tipo VARCHAR2(20),
    fotos REF(FotoUDT)
);

CREATE OR REPLACE TYPE MuseoUDT UNDER ServicioUDT (
    NombreMuseo VARCHAR2(20),
    Descripcion VARCHAR2(200),
    HoraInicio DATE,
    HoraFinal DATE,
    fotos REF(FotoUDT)
);

CREATE OR REPLACE TYPE BusUDT UNDER ServicioUDT (
    NombreBus VARCHAR2(20),
    Descripcion VARCHAR2(200),
    HoraInicio DATE,
    HoraFinal DATE,
    Duracion INTERVAL DAY TO SECOND,
    Frecuencia INTERVAL DAY TO SECOND
);

CREATE OR REPLACE TYPE FotoUDT AS OBJECT (
    id NUMBER,
    Foto VARCHAR2(20),
    Museo REF(MuseoUDT),
    Monumento REF(MonumentoUDT)
);

CREATE TABLE Cliente OF ClienteUDT (
    id PRIMARY KEY,
    nombre NOT NULL,
    apellidos NOT NULL,
    telefono CHECK (telefono < 10 AND telefono > 8),
    compras SCOPE IS CompraUDT ARRAY,
    REF IS SYSTEM GENERATED
);

CREATE TABLE Compra OF CompraUDT (
    id PRIMARY KEY,
    personas NOT NULL,
    cliente REFERENCES ClienteUDT,
    paquete REFERENCES PaqueteUDT,
    REF IS SYSTEM GENERATED
);

CREATE TABLE Paquete OF PaqueteUDT (
    id PRIMARY KEY,
    ciudad NOT NULL,
    compras SCOPE IS CompraUDT ARRAY,
    pertenece SCOPE IS PerteneceUDT ARRAY,
    REF IS SYSTEM GENERATED
);

CREATE TABLE Pertenece OF PerteneceUDT (
    precio NOT NULL,
    paquete REFERENCES PaqueteUDT,
    servicio REFERENCES ServicioUDT,
    REF IS SYSTEM GENERATED,
    PRIMARY KEY (servicio, paquete)
);

CREATE TABLE Servicio OF ServicioUDT (
    id PRIMARY KEY,
    precio_actual NOT NULL,
    REF IS SYSTEM GENERATED
);

CREATE TABLE Museo OF MuseoUDT (
    id PRIMARY KEY,
    NombreMuseo NOT NULL UNIQUE,
    Descripcion NOT NULL,
    HoraInicio NOT NULL,
    HoraFinal NOT NULL,
    REF IS SYSTEM GENERATED
);

CREATE TABLE Monumento OF MonumentoUDT (
    id PRIMARY KEY,
    NombreMonumento NOT NULL UNIQUE,
    Descripcion NOT NULL,
    HoraInicio NOT NULL,
    HoraFinal NOT NULL,
    REF IS SYSTEM GENERATED
);

CREATE TABLE Bus OF BusUDT (
    id PRIMARY KEY,
    NombreBus NOT NULL UNIQUE,
    Descripcion NOT NULL,
    HoraInicio NOT NULL,
    HoraFinal NOT NULL,
    Duracion INTERVAL DAY TO SECOND NOT NULL,
    Frecuencia INTERVAL DAY TO SECOND NOT NULL,
    REF IS SYSTEM GENERATED
);

CREATE TABLE Foto OF FotoUDT (
    id PRIMARY KEY,
    Museo REFERENCES MuseoUDT,
    Monumento REFERENCES MonumentoUDT,
    REF IS SYSTEM GENERATED
);
