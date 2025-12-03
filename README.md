# App Móvil Sist Control

## Descripción del Proyecto

**App Móvil Sist Control** es una aplicación móvil desarrollada en Flutter diseñada para la gestión y control de asistencia en instituciones educativas, específicamente para el Colegio San José. La aplicación permite a administradores y usuarios gestionar estudiantes, profesores, cursos y registrar asistencias de manera eficiente utilizando códigos QR.

### Características Principales

- **Autenticación de Usuarios**: Inicio de sesión para administradores y usuarios con almacenamiento seguro de tokens.
- **Panel de Control (Dashboard)**: Vista general con estadísticas de estudiantes presentes, total de estudiantes y registros de asistencia.
- **Gestión de Estudiantes**: Lista de estudiantes con información detallada, búsqueda y visualización de estado de asistencia.
- **Gestión de Profesores**: Administración de la lista de docentes registrados.
- **Gestión de Cursos**: Visualización y manejo de los cursos disponibles.
- **Generación de Códigos QR**: Creación de códigos QR únicos para cada estudiante basados en su identificación.
- **Escaneo de QR para Asistencia**: Registro de entrada y salida de estudiantes mediante escaneo de códigos QR con la cámara del dispositivo.
- **Lista de Asistencias**: Visualización de todas las asistencias registradas con detalles completos.

## Requisitos del Sistema

- **Flutter**: Versión 3.9.0 o superior
- **Dart**: Versión compatible con Flutter
- **Dispositivo Móvil**: Android o iOS con cámara para escaneo de QR
- **Conexión a Internet**: Para sincronización con el servidor backend

## Instalación

### Prerrequisitos

1. Instala Flutter siguiendo la [guía oficial](https://docs.flutter.dev/get-started/install).
2. Verifica la instalación ejecutando:
   ```bash
   flutter doctor
   ```

### Clonación y Configuración

1. Clona el repositorio:
   ```bash
   git clone <url-del-repositorio>
   cd app_movil_sist_control
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Configura el entorno (asegúrate de tener configurado el backend API si es necesario).

### Ejecución

- Para ejecutar en modo debug:
  ```bash
  flutter run
  ```

- Para construir el APK (Android):
  ```bash
  flutter build apk
  ```

- Para construir el IPA (iOS):
  ```bash
  flutter build ios
  ```

## Manual de Usuario

### Inicio de Sesión

1. Abre la aplicación.
2. Ingresa tu correo electrónico o nombre de usuario y contraseña.
3. Selecciona el tipo de usuario:
   - **Iniciar como Admin**: Para acceso completo a todas las funciones.
   - **Iniciar como Usuario**: Para acceso limitado según permisos.
4. Presiona el botón correspondiente para iniciar sesión.

### Panel de Control (Dashboard)

Después del inicio de sesión, accederás al panel principal que muestra:
- **Total de Estudiantes**: Número total registrado.
- **Registros Totales**: Número de asistencias registradas.
- **Acciones Principales**: Botones para acceder a diferentes secciones.

### Gestión de Estudiantes

1. Desde el dashboard, selecciona "Lista de Estudiantes".
2. Visualiza la lista completa de estudiantes con:
   - Nombre y apellido
   - Identificación
   - Correo electrónico
   - Hora de llegada (si aplica)
3. Usa la barra de búsqueda para filtrar por nombre o ID.

### Generación de Códigos QR

1. Selecciona "Generar QR Estudiante" desde el dashboard.
2. Ingresa el número de identificación del estudiante.
3. Presiona "Generar QR" para crear y mostrar el código QR único.
4. El estudiante puede usar este QR para registrar su asistencia.

### Registro de Asistencia

1. Selecciona "Escanear QR" desde el dashboard.
2. Elige el tipo de acción: "Entrada" o "Salida".
3. Apunta la cámara del dispositivo al código QR del estudiante.
4. La aplicación procesará automáticamente el registro y mostrará un mensaje de confirmación.

### Gestión de Profesores y Cursos

- **Lista de Profesores**: Accede para ver los docentes registrados.
- **Lista de Cursos**: Visualiza los cursos disponibles y su estado.

### Lista de Asistencias

1. Selecciona "Lista de Asistencias" para ver todas las asistencias registradas.
2. Incluye detalles como fecha, hora, estudiante y tipo de registro.

### Cierre de Sesión

- Desde el dashboard, presiona el ícono de logout en la esquina superior derecha para cerrar sesión y volver a la pantalla de inicio.

## Estructura del Proyecto

```
lib/
├── core/                 # Configuraciones globales (tema, constantes)
├── data/                 # Modelos de datos
├── presentation/         # Capa de presentación (páginas, widgets)
│   ├── pages/            # Páginas principales (login, dashboard, etc.)
│   └── widgets/          # Componentes reutilizables
├── routes/               # Configuración de rutas
└── services/             # Servicios para API y almacenamiento local
```

## Tecnologías Utilizadas

- **Flutter**: Framework para desarrollo móvil multiplataforma
- **Dart**: Lenguaje de programación
- **Mobile Scanner**: Para escaneo de códigos QR
- **QR Flutter**: Para generación de códigos QR
- **HTTP**: Para comunicación con APIs
- **Shared Preferences**: Para almacenamiento local de tokens

## Contribución

Para contribuir al proyecto:
1. Crea un fork del repositorio.
2. Crea una rama para tu feature: `git checkout -b feature/nueva-funcionalidad`
3. Realiza tus cambios y commits.
4. Envía un pull request.

## Soporte

Para soporte técnico o reportar problemas, contacta al equipo de desarrollo o crea un issue en el repositorio.

## Licencia

Este proyecto está bajo la licencia [especificar licencia, ej. MIT]. Consulta el archivo LICENSE para más detalles.
