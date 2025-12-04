import google.generativeai as genai
import os
import asyncio
import time
from pathlib import Path
from tqdm.asyncio import tqdm  # Para barra de progreso

# --- Configuración ---
API_KEY = os.environ.get('GEMINI_API_KEY')
if not API_KEY:
    print("Error: La variable de entorno GEMINI_API_KEY no está configurada.")
    exit(1)

genai.configure(api_key=API_KEY)

# Usamos Flash para rapidez y bajo costo, o Pro para mayor razonamiento.
# Asegúrate de usar un modelo existente.
MODEL_NAME = 'gemini-2.5-pro' 
project_root = Path("aplicacion_de_comprension")

# Límite de concurrencia para evitar errores 429 (Too Many Requests)
# Ajusta esto según tu tier de API (5-10 suele ser seguro para tier gratuito)
CONCURRENCY_LIMIT = 5 

# Archivos a ignorar (generados por build_runner, configuraciones, etc.)
IGNORE_PATTERNS = [
    ".g.dart", 
    ".freezed.dart", 
    "firebase_options.dart", 
    "generated_plugin_registrant.dart"
]

# --- Funciones ---

def find_dart_files(root_path: Path):
    """Busca recursivamente archivos .dart, excluyendo los generados."""
    dart_files = []
    if not root_path.exists():
        print(f"Error: No se encuentra el directorio {root_path}")
        return []

    for path in root_path.rglob("*.dart"):
        # Filtrar archivos ignorados
        if any(path.name.endswith(ignored) for ignored in IGNORE_PATTERNS):
            continue
        # Filtrar carpetas ocultas o de build
        if ".dart_tool" in str(path) or "build" in str(path):
            continue
            
        dart_files.append(path)
    return dart_files

async def generate_detailed_doc_async(model, file_path: Path, semaphore):
    """Genera documentación asíncrona respetando el semáforo."""
    async with semaphore: # Solo permite X ejecuciones simultáneas
        try:
            content = file_path.read_text(encoding='utf-8')
            if not content.strip():
                return None # Archivo vacío

            prompt = f"""
            Actúa como un Senior Technical Writer especializado en Flutter.
            Genera documentación en Markdown para el siguiente archivo: `{file_path.name}`.
            
            **Código fuente:**
            ```dart
            {content}
            ```

            **Requisitos de salida (Markdown):**
            1.  **Resumen:** Qué hace este archivo y su responsabilidad.
            2.  **Arquitectura:** Si es un Widget, un Provider, un Modelo o un Repositorio.
            3.  **Componentes Clave:** Tabla o lista de clases/métodos principales.
            4.  **No incluyas el código completo de nuevo**, solo fragmentos si es necesario para explicar.
            """
            
            # Llamada asíncrona a Gemini
            response = await model.generate_content_async(prompt)
            return response.text
            
        except Exception as e:
            # Manejo básico de errores de cuota (429) con reintento simple
            if "429" in str(e):
                print(f"\nRate limit en {file_path.name}, reintentando en 10s...")
                await asyncio.sleep(10)
                return await generate_detailed_doc_async(model, file_path, semaphore)
            return f"Error procesando {file_path.name}: {e}"

async def main():
    model = genai.GenerativeModel(MODEL_NAME)
    
    # 1. Buscar archivos automáticamente
    print(f"🔍 Buscando archivos .dart en {project_root}...")
    files_to_process = find_dart_files(project_root)
    
    if not files_to_process:
        print("No se encontraron archivos para documentar.")
        return

    print(f"📝 Se encontraron {len(files_to_process)} archivos para documentar.")
    
    # 2. Preparar tareas asíncronas
    semaphore = asyncio.Semaphore(CONCURRENCY_LIMIT)
    tasks = []
    
    # Creamos las tareas pero no las ejecutamos aún
    for file_path in files_to_process:
        tasks.append(generate_detailed_doc_async(model, file_path, semaphore))

    # 3. Ejecutar en
