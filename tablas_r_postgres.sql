
DROP TABLE IF EXISTS Clientes;

DROP TABLE IF EXISTS Oficinas;

DROP TABLE IF EXISTS Cuentas;

DROP TABLE IF EXISTS Titulares;

DROP TABLE IF EXISTS Operaciones;

-- Creación de tabla Clientes
CREATE TABLE Clientes (
    DNI         VARCHAR(9) PRIMARY KEY,
    nombre      VARCHAR(50) NOT NULL,
    apellidos   VARCHAR(50) NOT NULL,
    edad        INTEGER NOT NULL,
    direccion   VARCHAR(100) NOT NULL,
    email       VARCHAR(100),
    telefono    VARCHAR(20) NOT NULL
);

-- Creación de tabla Oficinas
CREATE TABLE Oficinas (
    codigo_oficina  INTEGER PRIMARY KEY,
    direccion       VARCHAR(100) NOT NULL,
    telefono        VARCHAR(20) NOT NULL
);

-- Creación de tabla Cuentas
CREATE TABLE Cuentas (
    numero_cuenta   INTEGER PRIMARY KEY,
    IBAN            VARCHAR(4) NOT NULL,
    fecha_creacion  DATE NOT NULL,
    saldo_actual    NUMERIC(10,2) DEFAULT 0.00,
    sucursal        INTEGER REFERENCES Oficinas(codigo_oficina),
    tipo_cuenta     VARCHAR(10) NOT NULL,
    CONSTRAINT      tipo_cuenta_check CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    CONSTRAINT      saldo_actual_check CHECK (saldo_actual >= 0.00)
);

-- Creación de tabla Titulares
CREATE TABLE Titulares (
    numero_cuenta   INTEGER REFERENCES Cuentas(numero_cuenta),
    DNI_titular     VARCHAR(9) REFERENCES Clientes(DNI),
    interes         NUMERIC(3,2) NOT NULL,  
    PRIMARY KEY (numero_cuenta, DNI_titular)
);

-- Creación de tabla Operaciones
CREATE TABLE Operaciones (
    id_operacion            INTEGER SERIAL PRIMARY KEY,
    fecha_hora              TIMESTAMP NOT NULL,
    cantidad                NUMERIC(10,2) NOT NULL,
    numero_cuenta_origen    INTEGER REFERENCES Cuentas(numero_cuenta),
    numero_cuenta_destino   INTEGER REFERENCES Cuentas(numero_cuenta),
    sucursal                INTEGER REFERENCES Oficinas(codigo_oficina),
    descripcion             VARCHAR(200),
    tipo_operacion          VARCHAR(15) NOT NULL,
    CONSTRAINT              tipo_operacion_check CHECK (tipo_operacion IN ('ingreso', 'retirada', 'transferencia'))
);