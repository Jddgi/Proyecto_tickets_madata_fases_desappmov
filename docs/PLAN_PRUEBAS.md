# Plan de pruebas MVP

| ID | Requisito | Escenario | Resultado esperado |
|---|---|---|---|
| CP-01 | RF01 | Login válido | Abre Dashboard |
| CP-02 | RF01 | Contraseña inválida | Muestra error y niega acceso |
| CP-03 | RF01 | Registro válido | Crea usuario y confirma |
| CP-04 | RF05 | Carga de Dashboard | Muestra métricas y alertas |
| CP-05 | RF09 | Consulta de infraestructura | Lista tres servidores simulados |
| CP-06 | RF13 | Alta de ticket válido | Persiste ticket en MySQL |
| CP-07 | RF13 | Ticket incompleto | Botón Guardar deshabilitado |
| CP-08 | RF18 | Consulta de alertas | Lista alertas simuladas |
| CP-09 | RF22 | Consulta de servicios | Recupera servicios desde API |
| CP-10 | Seguridad | Cerrar sesión | Regresa al Login |

Para cada prueba anexa fecha, dispositivo/simulador, datos usados, resultado real, estado y captura.
