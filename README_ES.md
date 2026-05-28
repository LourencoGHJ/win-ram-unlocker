# 🚀 Universal RAM Unlocker & Optimizer (by CONNECT Labs)

[⬅️ Volver al Menú Principal](./README.md)

![Plataforma](https://img.shields.io/badge/Plataforma-Windows%2010%20%7C%2011-lightgrey.svg)
![Licencia](https://img.shields.io/badge/Licencia-MIT-green.svg)

Un script batch multilingüe, ligero y automatizado, diseñado para corregir el famoso error de Windows donde cantidades masivas de memoria física (RAM) se asignan incorrectamente como **"Reservada para Hardware"** o quedan atrapadas en la **"Lista de Espera" (Standby List)**.

> 💡 **Nota del Creador (Gui - CONNECT):**
> *Creé y perfeccioné esta herramienta porque fue lo que VERÍDICAMENTE funcionó conmigo. Mi Windows estaba bloqueando mi memoria física, haciendo que el PC arrancara consumiendo unos absurdos **23GB de RAM** de la nada. ¡Tras aplicar este script, mi consumo al arrancar bajó inmediatamente a unos limpios y normales **6GB**!*

---

## 📸 Antes y Después (Evidencia Visual)

Dentro de la carpeta `/screenshots`, puedes ver las pruebas del diagnóstico:
* **Antes:** El Administrador de tareas de Windows mostrando una gran cantidad de RAM bloqueada en "Reservada para Hardware" o un caché del sistema completamente saturado.
* **Después:** Memoria total del sistema restaurada y completamente disponible para juegos (Valorant, CS) y procesos pesados.

---

## 🛠️ Guía de Restauración Paso a Paso

Para corregir completamente la asignación de memoria, sigue estos pasos en el orden correcto:

### Paso 1: Diagnóstico con RAMMap
1. Abre la herramienta **RAMMap** que descargaste directamente de Microsoft Sysinternals.
2. Mira la pestaña **Use Counts**.
3. Revisa las columnas **"Driver Locked"** y **"Standby"**. Si estos números son inusualmente altos, el kernel de tu Windows está gestionando mal la capa de hardware.

### Paso 2: Ejecutar el Script Automatizado
1. Descarga el archivo `Otimizador_RAM.bat` de este repositorio.
2. Haz clic derecho en el archivo y selecciona **"Ejecutar como Administrador"** (Crucial, ya que el script modifica variables de arranque y claves del registro del sistema).
3. Selecciona tu idioma de preferencia: **[3] Español**.
4. Lee el aviso y elige la **Opción [1] Ejecutar Diagnóstico y Desbloqueo Total**.
5. Cuando el script lo solicite, escribe `S` para **reiniciar tu PC**.

### Paso 3: Verificar la Solución
Después de reiniciar, abre tu **Administrador de tareas** -> **Rendimiento** -> **Memoria**. Verás que la memoria "Reservada para Hardware" ha disminuido drásticamente, devolviéndote la capacidad total de tu RAM.

---

## 🔍 ¿Qué hace este Script internamente?

A diferencia de los "limpiadores de RAM" genéricos que solo cierran procesos activos, esta herramienta ataca las variables raíz del sistema:
1. **Restablecimiento de BCDEdit:** Limpia truncamientos ocultos y límites de memoria máxima (`removememory` / `truncatememory`) configurados por error en `msconfig`.
2. **Remapeo de Registro de I/O:** Ajusta los valores de `ClearPageFileAtShutdown` y `LargeSystemCache` en el kernel de gestión de memoria para forzar la liberación del hardware en los ciclos del sistema.
3. **Vaciado de Caché y Explorer:** Cierra y reinicia de forma segura el subsistema de Windows Explorer mientras realiza un vaciado total de las tablas de caché internas y DNS.
4. **Recolección Activa de Basura (Garbage Collection):** Ejecuta un comando en segundo plano a través de PowerShell (`[System.GC]::Collect()`) para obligar al SO a liberar páginas muertas de controladores de hardware que ya no están en uso.

---

## 🤝 Contribuciones y Compartir

Si este script salvó el rendimiento de tus juegos o tu flujo de trabajo:
* ⭐ Deja una **Star** en este repositorio para que más personas puedan encontrarlo.
* 🔄 Comparte el enlace con amigos que sufran caídas de FPS en Discord o foros de tecnología.
