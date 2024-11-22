# Menú Interactivo RA 

Este proyecto es una aplicación multiplataforma que permite visualizar modelos 3D de platillos en un menú interactivo mediante realidad aumentada. 
Desarrollado para iOS y Android utilizando tecnologías como **SwiftUI**, **RealityKit**, **SceneView**, y **ARCore**.

---

### Visualización AR
![Vista de Realidad Aumentada](images/Prueba1.gif)
<img src="images/WhatsApp%20Image%202024-11-22%20at%2011.35.44%E2%80%AFa.%E2%80%AFm..jpeg" alt="Menú Principal" width="400">


---

## Características principales

- **Menú interactivo**: Lista de platillos con su nombre, precio y una opción para visualizar modelos 3D en realidad aumentada.
- **Soporte multiplataforma**: 
  - **iOS**: Implementación con SwiftUI y RealityKit.
  - **Android**: Uso de Jetpack Compose y SceneView con soporte de ARCore.
- **Visualización inmersiva**: Anclaje de modelos 3D a superficies detectadas.
- **Interfaz moderna**: Diseños intuitivos con tecnologías de interfaz declarativa.

---

## Implementación en Android

### Tecnologías utilizadas

- **Jetpack Compose**: Para la interfaz de usuario.
- **SceneView**: Para gestionar modelos 3D en AR.
- **ARCore**: Detección de superficies y anclaje de objetos.
- **Kotlin**: Lenguaje principal de desarrollo.
- **SwiftUI**: Para la construcción de interfaces de usuario declarativas.
- **RealityKit**: Para renderizar modelos 3D y gestionar la interacción de realidad aumentada.
- **ARKit**: Tecnología de detección de superficies y seguimiento en AR.
- **UIKit**: Funciones como botones y etiquetas en UIViewRepresentable.

## Requisitos del sistema iOS & Android

- iOS 16.0 o superior.
- Dispositivo compatible con **ARKit**.
- Xcode 15 o superior para compilar el proyecto.
  
- Versión de Android: 8.0 (Oreo) o superior.
- Soporte para AR: El dispositivo debe ser compatible con ARCore.
- Cámara trasera: Requerida para detección de superficies.


---

## Instalación

1. Clona este repositorio en tu máquina local:
   ```bash
   git clone https://github.com/tuusuario/menu-ra-android.git
