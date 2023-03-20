
DROP TABLE IF EXISTS Retirada_Ingreso;

DROP TABLE IF EXISTS Transferencia;

DROP TABLE IF EXISTS Operaciones;

DROP TABLE IF EXISTS Titulares;

DROP TABLE IF EXISTS Corriente;

DROP TABLE IF EXISTS Ahorro;

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

-- Cuenta ahorro
CREATE TABLE Ahorro () INHERITS (Cuentas);


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
    numero_cuenta_origen    BIGINT,
    descripcion             VARCHAR(200)
);


-- Operacion Transferencia
CREATE TABLE Transferencia (
    numero_cuenta_destino   BIGINT
) INHERITS (Operaciones);

-- Operacion Retirada_Ingreso
CREATE TABLE Retirada_Ingreso (
    sucursal                BIGINT REFERENCES Oficinas(codigo_oficina)
) INHERITS (Operaciones);

-- Función comprueba que exite el numero de cunta antes de añadirlo de titulares
CREATE OR REPLACE FUNCTION comprobar_numeroCuenta() RETURNS trigger AS $BODY$
    BEGIN 
        if EXISTS (select numero_cuenta FROM Cuentas WHERE cuentas.numero_cuenta = new.numero_cuenta ) then 
            RETURN NEW;
        else
            RETURN NULL;
        end if;
    END;
$BODY$ LANGUAGE plpgsql;

--Triger para inserción de datos en Titulares
CREATE OR REPLACE TRIGGER numero_cuenta_titulares 
    BEFORE INSERT ON titulares
    FOR EACH ROW
    EXECUTE FUNCTION comprobar_numeroCuenta();

-- Función comprueba que exite el numero de cunta antes de añadirlo de transferencia
CREATE OR REPLACE FUNCTION comprobar_numeroCuentaTransferencia() RETURNS trigger AS $BODY$
    BEGIN 
        if EXISTS (select numero_cuenta FROM Cuentas WHERE cuentas.numero_cuenta = new.numero_cuenta_destino) 
        AND EXISTS (select numero_cuenta FROM Cuentas WHERE cuentas.numero_cuenta = new.numero_cuenta_origen)then 
            RETURN NEW;
        else
            RETURN NULL;
        end if;
    END;
$BODY$ LANGUAGE plpgsql;

--Triger para inserción de datos en Transferencia
CREATE OR REPLACE TRIGGER numero_cuenta_transferencia 
    BEFORE INSERT ON Transferencia
    FOR EACH ROW
    EXECUTE FUNCTION comprobar_numeroCuentaTransferencia();

-- Función comprueba que exite el numero de cunta antes de añadirlo de Opereciones
CREATE OR REPLACE FUNCTION comprobar_numeroCuentaOpe() RETURNS trigger AS $BODY$
    BEGIN 
        if EXISTS (select numero_cuenta FROM Cuentas WHERE cuentas.numero_cuenta = new.numero_cuenta_origen) then 
            RETURN NEW;
        else
            RETURN NULL;
        end if;
    END;
$BODY$ LANGUAGE plpgsql;

--Triger para inserción de datos en Operaciones
CREATE OR REPLACE TRIGGER numero_cuenta_Operaciones 
    BEFORE INSERT ON Operaciones
    FOR EACH ROW
    EXECUTE FUNCTION comprobar_numeroCuentaOpe();
