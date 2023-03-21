SELECT cuentas.numero_cuenta FROM cuentas, Titulares, clientes WHERE dni = DNI_titular AND dni = '34567890D' AND cuentas.numero_cuenta = Titulares.numero_cuenta;

SELECT numero_cuenta FROM cuentas;

SELECT numero_cuenta FROM ahorro;

SELECT numero_cuenta FROM corriente;

SELECT numero_cuenta FROM ONLY cuentas;

SELECT cuentas.numero_cuenta FROM cuentas, Titulares, clientes WHERE dni = DNI_titular AND dni = '34567890D' AND cuentas.numero_cuenta = Titulares.numero_cuenta;