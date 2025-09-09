import google.generativeai as genai
import os
from pathlib import Path

# --- Configuración ---
try:
    # Configura la API key desde los secretos de GitHub
    api_key = os.environ['GEMINI_API_KEY']
    genai.configure(api_key=api_key)
    model = genai.GenerativeModel('gemini-pro')
except KeyError:
    print("Error: La variable de entorno GEMINI_API_KEY no está configurada.")
    exit(1)

# El directorio raíz del proyecto de Flutter dentro del repositorio
project_root = Path("aplicacion_de_comprension")

# Lista de archivos a documentar (rutas relativas al project_root)
files_to_document = [
    "lib/features/usuario/entidades/configuracion.dart",
    "lib/core/database/database.dart",
    "lib/core/hasher.dart",
    "lib/core/proveedor.dart",
    "lib/core/seguridad.dart",
    "lib/features/secciones/presentacion/paginas/introduccion.dart",
    "lib/features/secciones/presentacion/paginas/resorte.dart",
    "lib/features/secciones/repositorios/autenticacion.dart",
    "lib/features/secciones/repositorios/repoconfig.dart",
    "lib/features/secciones/repositorios/repoperfil.dart",
    "lib/features/secciones/repositorios/repotutor.dart",
    "lib/features/usuario/entidades/perfil.dart",
    "lib/features/usuario/entidades/usuario.dart",
    "lib/features/usuario/presentacion/controladores/cargar.dart",
    "lib/features/usuario/presentacion/controladores/contautenticacion.dart",
    "lib/features/usuario/presentacion/estados/autenticacion.dart",
    "lib/features/usuario/presentacion/paginas/login.dart",
    "lib/features/usuario/presentacion/paginas/personajes.dart",
    "lib/features/usuario/presentacion/paginas/registro.dart",
    "lib/features/usuario/repositorios/autenticacion.dart",
    "lib/features/usuario/repositorios/repoconfig.dart",
    "lib/features/usuario/repositorios/repoperfil.dart",
    "lib/features/usuario/repositorios/repotutor.dart",
    "lib/main.dart"
]

# --- Funciones ---

def generate_detailed_doc(file_path: Path):
    """Genera documentación detallada para un solo archivo."""
    print(f"Generando documentación para: {file_path}...")
    try:
        content = file_path.read_text(encoding='utf-8')
        
        prompt = f"""
        Eres un programador experto en Flutter y Dart especializado en crear documentación técnica clara y concisa.
        Tu tarea es documentar el siguiente archivo de código.

        **Instrucciones:**
        1.  Analiza el propósito general del archivo.
        2.  Documenta cada clase, método, y propiedad importante usando los comentarios de documentación de Dart (`///`).
        3.  Genera un resumen en formato Markdown que explique la funcionalidad del archivo, sus dependencias principales y su rol dentro de la aplicación.
        4.  El resultado final debe ser un único bloque de texto en formato Markdown.

        **Código a documentar:**
        ```dart
        {content}
        ```
        """
        
        response = model.generate_content(prompt)
        return response.text
    except Exception as e:
        return f"Error al procesar el archivo {file_path}: {e}"

def generate_index_doc(file_list):
    """Genera el archivo de índice DOCUMENTACION.md."""
    print("Generando el archivo de índice (DOCUMENTACION.md)...")
    
    # Prepara la lista de archivos para el prompt
    file_structure = "\n".join([f"- `{file}`" for file in file_list])
    
    prompt = f"""
    Eres un arquitecto de software creando el índice para la documentación de un proyecto Flutter.
    La estructura de archivos del proyecto es la siguiente:
    {file_structure}

    **Instrucciones:**
    1.  Crea un documento llamado `DOCUMENTACION.md`.
    2.  Organiza la documentación por módulos (ej: Core, Features, etc.) basándote en la estructura de carpetas.
    3.  Para cada archivo, escribe una descripción de una sola línea sobre su posible propósito.
    4.  Crea un enlace relativo en formato Markdown para cada archivo que apunte a su documentación detallada en la carpeta `docs/`. Por ejemplo, para `lib/core/hasher.dart`, el enlace debe ser `[hasher.dart](./docs/lib/core/hasher.dart.md)`.

    El resultado debe ser un documento Markdown completo y bien estructurado.
    """
    
    response = model.generate_content(prompt)
    return response.text

# --- Ejecución Principal ---

# 1. Generar documentación detallada para cada archivo
for file_str in files_to_document:
    file_path = project_root / file_str
    if file_path.exists():
        # Generar documentación
        markdown_content = generate_detailed_doc(file_path)
        
        # Crear la ruta de salida para el archivo de documentación
        output_path = project_root / "docs" / file_str
        output_path = output_path.with_suffix(".md") # Cambiar la extensión a .md
        
        # Asegurarse de que el directorio de salida exista
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        # Escribir el contenido
        output_path.write_text(markdown_content, encoding='utf-8')
        print(f"Documentación guardada en: {output_path}")
    else:
        print(f"Advertencia: El archivo no se encontró: {file_path}")

# 2. Generar el archivo de índice
index_content = generate_index_doc(files_to_document)
index_path = project_root / "DOCUMENTACION.md"
index_path.write_text(index_content, encoding='utf-8')
print(f"Índice de documentación guardado en: {index_path}")

print("¡Proceso de documentación completado!")