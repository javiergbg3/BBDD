INSERT INTO clientes (dni, nombre, apellidos, edad, direccion, email, telefono) VALUES
    ('12345678A', 'jj', 'ramirez', 56, 'Calle Mayor Nº 67', , 689789789),
    ('87654321B', 'Luisa', 'García', 42, 'Calle de la Luna Nº 12', 'luisa.garcia@gmail.com', 654987321),
    ('23456789C', 'Javier', 'Fernández', 28, 'Avenida de la Playa Nº 23', 'javier.fernandez@hotmail.com', 678901234),
    ('34567890D', 'Sofía', 'Martínez', 35, 'Calle de la Paz Nº 8', 'sofia.martinez@gmail.com', 789012345),
    ('45678901E', 'David', 'González', 53, 'Plaza del Sol Nº 17', 'david.gonzalez@yahoo.com', 890123456),
    ('56789012F', 'Elena', 'Rodríguez', 31, 'Calle del Mar Nº 3', 'elena.rodriguez@gmail.com', 901234567);

INSERT INTO Oficinas (codigo_oficina, direccion, telefono) VALUES
    (1001, 'Calle Mayor Nº 12', '123456789'),
    (1002, 'Avenida del Mar Nº 23', '234567890'),
    (1003, 'Calle del Sol Nº 45', '345678901'),
    (1004, 'Plaza de la Constitución Nº 56', '456789012'),
    (1005, 'Avenida de la Paz Nº 67', '567890123'),
    (1006, 'Calle de la Luna Nº 78', '678901234'),
    (1007, 'Plaza del Ayuntamiento Nº 89', '789012345'),
    (1008, 'Calle de la Estación Nº 90', '890123456'),
    (1009, 'Avenida de la Libertad Nº 101', '901234567'),
    (1010, 'Calle del Pilar Nº 112', '123456789');

INSERT INTO Cuentas (numero_cuenta, IBAN, fecha_creacion, saldo_actual, 10ursal, tipo_cuenta) VALUES
    (1234567890123456, 'ES5512345678901234567890', '2021-01-01', 5000.00, 1001, 'corriente'),
    (2345678901234567, 'ES5623456789012345678901', '2020-06-15', 15000.00, 1002, 'ahorro'),
    (3456789012345678, 'ES5734567890123456789012', '2019-10-20', 2000.00, 1003, 'corriente'),
    (4567890123456789, 'ES5845678901234567890123', '2022-02-28', 100000.00, 1004, 'ahorro'),
    (5678901234567890, 'ES5956789012345678901234', '2022-01-15', 500.00, 1005, 'corriente'),
    (6789012345678901, 'ES6067890123456789012345', '2020-12-01', 7500.00, 1006, 'ahorro'),
    (7890123456789012, 'ES6178901234567890123456', '2021-05-10', 25000.00, 1007, 'corriente'),
    (8901234567890123, 'ES6289012345678901234567', '2018-11-30', 8000.00, 1008, 'ahorro'),
    (9012345678901234, 'ES6390123456789012345678', '2019-07-12', 1000.00, 1009, 'corriente'),
    (0123456789012345, 'ES6401234567890123456789', '2022-03-01', 15000.00, 1010, 'ahorro');

INSERT INTO Titulares (numero_cuenta, DNI_titular, interes) VALUES
    (1234567890123456, '34567890D', 1.50),
    (2345678901234567, '87654321B', 1.25),
    (3456789012345678, '23456789C', 1.75),
    (4567890123456789, '34567890D', 2.00),
    (5678901234567890, '45678901E', 1.00),
    (6789012345678901, '56789012F', 1.50),
    (7890123456789012, '12345678A', 1.75),
    (8901234567890123, '87654321B', 2.25),
    (9012345678901234, '34567890D', 1.50),
    (0123456789012345, '12345678A', 1.25);

INSERT INTO Operaciones (fecha_hora, cantidad, numero_cuenta_origen, numero_cuenta_destino, sucursal, descripcion, tipo_operacion) VALUES
    ('2023-03-15 10:30:00', 1000.00, 1234567890123456, 4567890123456789, 1001, 'Transferencia a cuenta de ahorros', 'transferencia'),
    ('2023-05-17 16:30:00', 800.00, 8901234567890123, , 1004, 'Nomina', 'ingreso'),
    ('2023-05-17 16:30:00', 50.00, 9012345678901234, , 1008, , 'retirada');