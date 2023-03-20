
DROP TABLE IF EXISTS Retirada_Ingreso;

DROP TABLE IF EXISTS Transferencia;

DROP TABLE IF EXISTS Operaciones;

DROP TABLE IF EXISTS Titulares;

DROP TABLE IF EXISTS Corriente;

DROP TABLE IF EXISTS Cuentas;

DROP TABLE IF EXISTS Oficinas;

DROP TABLE IF EXISTS Clientes;


-- Creación de tabla Clientes
CREATE TABLE Clientes (
    DNI         VARCHAR(9) PRIMARY KEY,
    nombre      VARCHAR(50) NOT NULL,
    apellidos   VARCHAR(50) NOT NULL,
    edad        BIGINT NOT NULL,
    direccion   VARCHAR(100) NOT NULL,
    email       VARCHAR(100),
    telefono    VARCHAR(20) NOT NULL
);

-- Creación de tabla Oficinas
CREATE TABLE Oficinas (
    codigo_oficina  BIGINT PRIMARY KEY,
    direccion       VARCHAR(100) NOT NULL,
    telefono        VARCHAR(20) NOT NULL
);

-- Creación de tabla Cuentas
CREATE TABLE Cuentas (
    numero_cuenta   BIGINT PRIMARY KEY,
    IBAN            VARCHAR(24) NOT NULL,
    fecha_creacion  DATE NOT NULL,
    saldo_actual    NUMERIC(10,2) DEFAULT 0.00,
    CONSTRAINT      saldo_actual_check CHECK (saldo_actual >= 0.00)
);


-- Cuenta corriente
CREATE TABLE Corriente (
    sucursal        BIGINT NOT NULL REFERENCES Oficinas(codigo_oficina)
) INHERITS (Cuentas);


--Triger para inserción de datos en Titulares
CREATE OR REPLACE TRIGGER numero_cuenta_titulares 
    BEFORE INSERT ON Titulares
    FOR EACH ROW
    EXECUTE comprobar_numeroCuenta();


-- Función comprueba que exite el numero de cunta antes de añadirlo
CREATE OR REPLACE FUNCTION comprobar_numeroCuenta()
RETURN trigger AS 
$BODY$
BEGIN 
    if EXISTS (select numero_cuenta FROM Cuentas WHERE cuentas.numero_cuenta = new.numero_cuenta ) then 
        RETURN NEW;
    else
        RETURN NULL;
    end if;
END;
$BODY$
LANGUAGE plpgsql;


    if EXISTS (select numero_cuenta FROM Cuentas WHERE cuentas.numero_cuenta = new.numero_cuenta ) then 
        RETURN NEW;
    else
        RETURN NULL;
    end if;

-- Creación de tabla Titulares
CREATE TABLE Titulares (
    numero_cuenta   BIGINT,
    DNI_titular     VARCHAR(9) REFERENCES Clientes(DNI),
    interes         NUMERIC(3,2) NOT NULL,  
    PRIMARY KEY (numero_cuenta, DNI_titular)
);

-- Creación de tabla Operaciones
CREATE TABLE Operaciones (
    id_operacion            SERIAL PRIMARY KEY,
    fecha_hora              TIMESTAMP NOT NULL,
    cantidad                NUMERIC(10,2) NOT NULL,
    numero_cuenta_origen    BIGINT REFERENCES Cuentas(numero_cuenta),
    descripcion             VARCHAR(200)
);


-- Operacion Transferencia
CREATE TABLE Transferencia (
    numero_cuenta_destino   BIGINT REFERENCES Cuentas(numero_cuenta)
) INHERITS (Operaciones);

-- Operacion Retirada_Ingreso
CREATE TABLE Retirada_Ingreso (
    sucursal                BIGINT REFERENCES Oficinas(codigo_oficina)
) INHERITS (Operaciones);