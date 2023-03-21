SELECT cuentas.numero_cuenta FROM cuentas, Titulares, clientes WHERE dni = DNI_titular AND dni = '34567890D' AND cuentas.numero_cuenta = Titulares.numero_cuenta;

SELECT numero_cuenta FROM cuentas;

SELECT numero_cuenta FROM ahorro;

SELECT numero_cuenta FROM corriente;

SELECT numero_cuenta FROM ONLY cuentas;

SELECT id_operacion FROM Operaciones;

SELECT id_operacion FROM Transferencia;

SELECT id_operacion FROM Retirada;

SELECT id_operacion FROM Ingreso;

SELECT id_operacion FROM ONLY Operaciones;