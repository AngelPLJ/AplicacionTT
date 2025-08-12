# 🚀 Guía de instalación de entorno Flutter (Windows)

Este documento explica **cómo instalar y configurar** todas las herramientas necesarias para desarrollar aplicaciones Flutter para **Android** y **Windows Desktop**.

---

## 📌 1. Requisitos previos
- Windows 10 u 11 (64 bits)
- Conexión a internet
- Espacio en disco: **mínimo 15 GB** (Android Studio + Visual Studio + SDKs)

---

## 📌 2. Instalar Flutter SDK

1. Descargar Flutter SDK desde:
   👉 [https://flutter.dev/docs/get-started/install/windows](https://flutter.dev/docs/get-started/install/windows)

2. Verificar instalación:
```powershell
flutter --version

3. Instalar Visual Studio 2022 (para desarrollo Windows Desktop)
⚠️ No confundir con Visual Studio Code. Flutter para Windows necesita Visual Studio 2022 con herramientas de C++.

    Descargar Visual Studio Community 2022:
    👉 [https://visualstudio.microsoft.com/downloads](https://visualstudio.microsoft.com/downloads)

    Abrir el instalador y marcar:

        Desktop development with C++

    En la sección de Componentes individuales, asegurarse de tener:

        ✅ C++ CMake tools for Windows

        ✅ MSVC v143 - VS 2022 C++ x64/x86 build tools

        (Opcional) C++ AddressSanitizer

    Instalar y reiniciar.

4. Instalar android studio:
    [https://developer.android.com/studio](https://developer.android.com/studio)