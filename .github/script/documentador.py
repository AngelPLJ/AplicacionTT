import google.generativeai as genai
import os
import asyncio
from pathlib import Path
from tqdm.asyncio import tqdm

# --- Configuración ---
API_KEY = os.environ.get('GEMINI_API_KEY')
if not API_KEY:
    print("Error: GEMINI_API_KEY no configurada.", flush=True)
    exit(1)

genai.configure(api_key=API_KEY)

MODEL_NAME = 'gemini-2.5-flash'
project_root = Path("aplicacion_de_comprension")

# REDUCIMOS CONCURRENCIA: 3 es más seguro para evitar bloqueos
CONCURRENCY_LIMIT = 1 

# TIEMPO MÁXIMO POR ARCHIVO (Segundos)
TIMEOUT_PER_FILE = 120

IGNORE_PATTERNS = [
    ".g.dart", 
    ".freezed.dart", 
    "firebase_options.dart", 
    "generated_plugin_registrant.dart"
]

# --- Funciones ---

def find_dart_files(root_path: Path):
    dart_files = []
    if not root_path.exists():
        print(f"Error: No se encuentra el directorio {root_path}")
        return []

    for path in root_path.rglob("*.dart"):
        if any(path.name.endswith(ignored) for ignored in IGNORE_PATTERNS):
            continue
        if ".dart_tool" in str(path) or "build" in str(path):
            continue
        dart_files.append(path)
    return dart_files

async def generate_detailed_doc_async(model, file_path: Path, semaphore):
    async with semaphore:
        try:
            content = file_path.read_text(encoding='utf-8')
            if not content.strip():
                return None

            prompt = f"""
            Actúa como un Senior Technical Writer experto en Flutter.
            Genera documentación Markdown para: `{file_path.name}`.
            
            **Código:**
            ```dart
            {content}
            ```

            **Salida:** Resumen, Arquitectura (Widget/Provider/Repo), y Componentes Clave.
            """
            
            # --- PROTECCIÓN CONTRA CONGELAMIENTO ---
            # Si la API no responde en 60s, cancelamos este archivo
            response = await asyncio.wait_for(
                model.generate_content_async(prompt),
                timeout=TIMEOUT_PER_FILE
            )
            return response.text
            
        except asyncio.TimeoutError:
            return f"Error: Tiempo de espera agotado ({TIMEOUT_PER_FILE}s) para {file_path.name}"
        except Exception as e:
            if "429" in str(e):
                return "Error: Rate limit (429) excedido."
            return f"Error procesando {file_path.name}: {e}"

async def main():
    model = genai.GenerativeModel(MODEL_NAME)
    
    print(f"🔍 Buscando archivos en {project_root}...", flush=True)
    files_to_process = find_dart_files(project_root)
    
    if not files_to_process:
        print("No se encontraron archivos.", flush=True)
        return

    print(f"📝 {len(files_to_process)} archivos encontrados. Procesando con límite de {CONCURRENCY_LIMIT} hilos...", flush=True)
    
    semaphore = asyncio.Semaphore(CONCURRENCY_LIMIT)
    tasks = [generate_detailed_doc_async(model, f, semaphore) for f in files_to_process]

    # Ejecutar tareas
    results = await tqdm.gather(*tasks, desc="Generando Docs")

    # Guardar
    docs_created = []
    for file_path, doc_content in zip(files_to_process, results):
        if doc_content and "Error" not in doc_content:
            relative_path = file_path.relative_to(project_root)
            output_path = project_root / "docs" / relative_path.with_suffix(".md")
            output_path.parent.mkdir(parents=True, exist_ok=True)
            output_path.write_text(doc_content, encoding='utf-8')
            docs_created.append(str(relative_path))
        else:
            # Imprimir error para depuración
            print(f"\n❌ {file_path.name}: {doc_content}")

    # Índice
    if docs_created:
        print("\n📚 Generando índice...", flush=True)
        try:
            index_prompt = f"Crea un índice Markdown (DOCUMENTACION.md) para estos archivos:\n{chr(10).join(docs_created)}"
            response = await asyncio.wait_for(
                model.generate_content_async(index_prompt), 
                timeout=60
            )
            index_path = project_root / "DOCUMENTACION.md"
            index_path.write_text(response.text, encoding='utf-8')
            print("✅ Hecho.", flush=True)
        except Exception as e:
            print(f"Error generando índice: {e}")

if __name__ == "__main__":
    asyncio.run(main())
