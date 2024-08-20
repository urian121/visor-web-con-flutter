# Tecno Escuela Gaitán App

## Descripción

Tecno Escuela Gaitán es una aplicación Flutter diseñada para proporcionar un acceso sencillo a una página web mediante un navegador integrado. La aplicación permite a los usuarios registrar y almacenar una URL que se puede visitar en un `WebView` dentro de la aplicación. Además, incluye una interfaz amigable con botones para cambiar la URL y visitar el sitio web registrado.

## Funcionalidades

- **Registrar URL:** Permite a los usuarios ingresar y registrar una nueva URL mediante un formulario.
- **Visitar Sitio Web:** Ofrece un botón para abrir la URL registrada en un `WebView` integrado en la aplicación.
- **Persistencia de URL:** Utiliza `SharedPreferences` para guardar y recuperar la última URL registrada, de manera que persista incluso si la aplicación se cierra y se vuelve a abrir.
- **Interfaz de Usuario:** Diseñada con un diseño limpio y botones estilizados para una experiencia de usuario intuitiva.

## Estructura del Proyecto

El proyecto está dividido en varios archivos para mantener una estructura organizada:

- **`main.dart`:** Contiene la configuración principal de la aplicación y la inicialización del `WebView`.
- **`webview_app.dart`:** Implementa la interfaz principal de la aplicación y maneja la lógica de carga de la URL.
- **`segunda_page.dart`:** Proporciona un formulario para registrar una nueva URL.
- **`web_chrome_client.dart`:** Define la clase `WebChromeClient` para manejar excepciones en el `WebView`.
- **`web_exception.dart`:** Define la clase `WebException` para gestionar excepciones en el `WebView`.

## Instalación
Para instalar y ejecutar la aplicación, sigue estos pasos:

1. Verifica la Configuración del Entorno
    $ flutter doctor
    $ flutter upgrade


2. Instala las Dependencias
    $ flutter clean
    $ flutter pub get

3. Ejecuta el Proyecto
    $ flutter run

4. Construir para una Plataforma Específica (Opcional)
    $ flutter build apk 
    $ flutter build apk --release



# Configuración de Permisos
Se han agregado los siguientes permisos en el archivo AndroidManifest.xml para permitir el acceso a internet y al estado de la red.

    <!-- Agrega los permisos aquí -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>