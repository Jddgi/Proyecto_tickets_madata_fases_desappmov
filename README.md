# MADATA Mobile MVP

MVP académico para gestión de tickets, consulta de servicios, monitoreo simulado y alertas de MADATA.

## Stack
- iOS 17+, Swift 5.9, SwiftUI
- Arquitectura MVVM
- API REST en PHP 8 + MySQL 8
- Datos reales para autenticación, servicios y tickets
- Datos simulados para monitoreo y alertas

## Requisitos
- macOS con Xcode 15 o posterior
- XcodeGen (`brew install xcodegen`)
- XAMPP/MAMP/Laragon o PHP 8 + MySQL

## Inicio rápido
1. Ejecuta `backend/database/schema.sql` en MySQL.
2. Copia `backend/api` al directorio público de tu servidor PHP.
3. Edita `backend/api/config/database.php` con tus credenciales.
4. Verifica `http://localhost/madata-api/health.php`.
5. Edita `MADATA/Config/AppConfig.swift` y coloca la URL de tu API.
   - Simulador iOS: `http://127.0.0.1/madata-api`
   - iPhone físico: usa la IP local de tu Mac, por ejemplo `http://192.168.1.10/madata-api`
6. En la raíz ejecuta `xcodegen generate`.
7. Abre `MADATA.xcodeproj`, selecciona un simulador y ejecuta.

## Usuario de demostración
- Correo: `demo@madata.mx`
- Contraseña: `Demo1234!`

## Funcionalidades MVP
- RF01: inicio de sesión y registro
- RF05: dashboard ejecutivo
- RF09: monitoreo simulado de infraestructura
- RF13: alta y consulta de tickets
- RF18: alertas simuladas
- RF22: consulta de servicios contratados
- Cierre de sesión

## Endpoints
- `GET /health.php`
- `POST /auth/register.php`
- `POST /auth/login.php`
- `GET /tickets/list.php?user_id=1`
- `POST /tickets/create.php`
- `PATCH /tickets/update.php`
- `GET /services/list.php?user_id=1`

## Evidencia sugerida
Captura: estructura en Xcode, `BUILD SUCCEEDED`, login, dashboard, alta de ticket, ticket en MySQL y ejecución de pruebas.

## Alcance y seguridad
Proyecto académico con datos ficticios. No usar credenciales reales ni desplegar como sistema de producción. La autenticación usa hash de contraseña, consultas preparadas y token simple de demostración; una versión productiva requeriría HTTPS, JWT/OAuth, gestión de secretos y controles adicionales.
