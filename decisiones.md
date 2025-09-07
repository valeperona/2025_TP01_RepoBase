# Trabajo Práctico 01 – Git Básico (2025)

## Archivo: decisiones.md

---

## Parte 1 – Configurar tu entorno y preparar tu repositorio

### Consigna
- Cloná o forkeá el repositorio base https://github.com/ingsoft3ucc/2025_TP01_RepoBase  
- Configurá tu identidad y dejá constancia en este archivo de cómo lo hiciste.

### Flujo de trabajo utilizado

1. **Fork en GitHub** del repositorio `ingsoft3ucc/2025_TP01_RepoBase`  
   → Me permitió tener una copia propia con permisos de escritura.

2. **Clonado del fork** usando GitHub Desktop para manejar automáticamente la autenticación.

3. **Configuración de Git en mi máquina (terminal):**
   ```bash
   git config --global user.name  "Valentina Perona"
   git config --global user.email "2112356@ucc.edu.ar"
   git config --global init.defaultBranch main
   git config --global core.editor "code --wait"
   ```

### Por qué se hizo así
- El fork me permite trabajar en mi propio repositorio sin modificar el original de la cátedra.
- GitHub Desktop facilita el login sin necesidad de tokens por consola.
- Configurar nombre/email asegura trazabilidad de cada commit.
- Usar main como rama por defecto sigue la convención actual de GitHub.
- Configurar VSCode como editor me facilita escribir mensajes largos de commit o resolver conflictos.

### Alternativas descartadas
- **Clonar directo el repo de la cátedra:** no hubiera podido hacer push.
- **Hacer commits en main:** no es buena práctica, no habría orden ni revisión.
- **Usar nano/vi:** preferí VSCode por comodidad.

### Problemas y soluciones
**Problema:** al hacer `git push` por terminal me pedía usuario/contraseña y daba error ("Password authentication is not supported").

**Solución:** usé GitHub Desktop para manejar la autenticación. Más adelante, para el tag, utilicé la Release en GitHub web.

---

## Parte 2 – Desarrollar una funcionalidad

### Consigna
- Trabajá en una rama separada de main.
- Hacé al menos 2 commits atómicos con mensajes claros.
- Justificá la estrategia que usaste.

### Flujo de trabajo utilizado

1. **Creé una rama de feature:**
   ```bash
   git checkout -b feature/mi-funcionalidad
   ```

2. **Commit 1 (funcionalidad mínima):**
   - **Archivo:** `scripts/linecount.sh`
   - **Contenido:** script en Bash que usa `wc -l` para contar líneas.
   ```bash
   git add scripts/linecount.sh
   git commit -m "feat(linecount): agrega script para contar líneas en un archivo"
   ```

3. **Commit 2 (documentación):**
   - **Edición de README.md** con ejemplo de uso.
   ```bash
   git add README.md
   git commit -m "docs(linecount): documenta ejemplo de uso del script en README"
   ```

### Por qué se hizo así
- **Rama de feature:** aislar el trabajo y evitar romper main.
- **Commits atómicos:** separan código y documentación, lo que mejora la claridad y permite revertir un cambio sin perder el otro.

### Alternativas descartadas
- **Un único commit con todo** → menos trazabilidad.
- **Seguir en main** → rompe la idea de flujo de trabajo profesional.

### Problemas y soluciones
Ninguno en esta parte.

---

## Parte 3 – Corregir un error (simulado) y aplicar el fix

### Consigna
- Simulá un error en main y resolvelo en una rama hotfix.
- Aplicá el fix a main y también a tu rama de desarrollo.
- Elegí cómo lo integrás (merge, cherry-pick, etc.) y explicalo.

### Flujo de trabajo utilizado

1. **Simulé un bug en main:**
   ```bash
   git checkout main
   git pull
   echo "BUG_SIMULADO: Enlace/doc roto" >> README.md
   git add README.md
   git commit -m "bug(readme): introduce error simulado en documentación"
   git push origin main
   ```

2. **Creé la rama de hotfix y corregí:**
   ```bash
   git checkout -b hotfix/readme-bug
   # edité README.md y borré la línea BUG_SIMULADO
   git add README.md
   git commit -m "fix(readme): elimina línea problemática del bug simulado"
   ```

3. **Integré el hotfix en main con merge no-ff:**
   ```bash
   git checkout main
   git merge --no-ff hotfix/readme-bug -m "merge: integra hotfix de README en main"
   git push origin main
   git branch -d hotfix/readme-bug
   ```

4. **Propagué el fix a la rama de feature con cherry-pick:**
   ```bash
   git checkout feature/mi-funcionalidad
   git cherry-pick <hash_del_fix>
   git push origin feature/mi-funcionalidad
   ```

### Por qué se hizo así
- **Hotfix en rama dedicada:** patrón recomendado para errores en producción.
- **Merge con `--no-ff`:** deja un commit de merge que documenta explícitamente que hubo un hotfix.
- **Cherry-pick a la feature:** traje solo el fix sin incorporar otros commits de main → evita ruido y conflictos.

### Alternativas descartadas
- **merge main en la feature:** traería todo lo nuevo de main, no solo el fix.
- **git reset en main:** no se usa porque reescribe historia y en un repo compartido es peligroso.

### Problemas y soluciones
**Problema:** Conflicto en README.md al actualizar el PR.

**Solución:**
- Lo reproduje localmente con `git merge origin/main`.
- Edité el archivo, eliminé marcadores `<<<<<<< ======= >>>>>>>` y dejé la versión correcta.
- Luego:
  ```bash
  git add README.md
  git commit -m "chore: resuelve conflicto de README entre main y feature"
  git push origin feature/mi-funcionalidad
  ```

---

## Parte 4 – Hacer un Pull Request y aceptarlo

### Consigna
Crear un PR y aceptarlo.

### Flujo de trabajo utilizado
- **En GitHub web:** PR `feature/mi-funcionalidad` → `main`.
- Inicialmente el PR mostró conflicto (resuelto en la Parte 3).
- Una vez resuelto, hice el merge con la opción **Create a merge commit**.
- Eliminé la rama `feature/mi-funcionalidad` en remoto.

### Por qué se hizo así
- **PR:** permite revisión, discusión y registro de los cambios.
- **Merge commit:** mantiene los dos commits atómicos de la feature → cumple la consigna.
- **Eliminar rama:** práctica recomendada para mantener el repo limpio.

### Alternativas descartadas
- **Squash & merge:** pierde la granularidad de los commits → no cumple con la consigna.
- **Rebase & merge:** reescribe historia → no es recomendable en main.

### Problemas y soluciones
- El conflicto en README.md ya se resolvió en la Parte 3.
- Tras el push, el PR se pudo mergear sin problemas.

---

## Parte 5 – Crear una versión etiquetada

### Consigna
- Marcá una versión estable con el tag v1.0.
- Explicá qué convenciones usaste y por qué.

### Flujo de trabajo utilizado

1. **En local:**
   ```bash
   git checkout main
   git pull
   git tag -a v1.0 -m "v1.0: primera versión estable (feature + hotfix integrados)"
   ```

2. **Intenté** `git push origin v1.0`, pero dio error de autenticación (GitHub ya no acepta password por HTTPS).

3. **Resolución:**
   - Creé el tag v1.0 y la Release directamente en **GitHub web**, apuntando al commit final en main.
   - Al hacer `git fetch --tags` apareció el error "would clobber existing tag" porque el tag local apuntaba a otro commit.

4. **Solución:**
   ```bash
   git tag -d v1.0
   git fetch --tags
   ```
   Con eso, el tag local quedó sincronizado con el remoto.

### Por qué se hizo así
- **Tag anotado:** guarda autor, fecha y mensaje → más profesional y trazable.
- **Convención SemVer:** usé v1.0 (Major.Minor.Patch) porque es la primera versión estable con feature y fix integrados.
- **Release en GitHub:** facilita mostrar el hito y documentar el changelog en la defensa.

### Alternativas descartadas
- **Tag ligero** (`git tag v1.0`) → no guarda metadata → menos trazabilidad.
- **Forzar push de tags por CLI** (`git push --force --tags`) → peligroso, puede sobrescribir historial en remoto. Preferí sincronizar con el tag creado en la web.

### Problemas y soluciones
**Problema 1:** error de autenticación al pushear por CLI.  
→ **Solución:** usar GitHub Desktop/web (maneja login con token).

**Problema 2:** conflicto de tag entre local y remoto.  
→ **Solución:** borrar el tag local y volver a traer el remoto con `git fetch --tags`.

---

## Conclusiones y buenas prácticas

- El flujo de trabajo con ramas (feature/hotfix + main) asegura orden y evita romper producción.
- Los commits atómicos facilitan revisión, entendimiento y reversión.
- El merge no-ff para hotfix deja trazabilidad clara en la historia.
- El cherry-pick permite aplicar solo el fix necesario a una rama en desarrollo.
- El PR con merge commit mantiene transparencia y preserva el detalle de los commits.
- El tag v1.0 anotado + Release marca un hito estable y visible públicamente.
- Problemas resueltos (autenticación, conflictos, tags) demuestran capacidad de enfrentar situaciones reales.

---

## Preguntas de defensa (respuestas preparadas)

### ¿Qué hace git rebase?
Reaplica commits sobre otra rama reescribiendo la historia. No lo usé en main porque puede romper la historia compartida; preferí merges explícitos.

### ¿Cómo revertís un commit ya pusheado?
Con `git revert <hash>`, que genera un commit inverso sin alterar la historia.

### ¿Por qué merge --no-ff en hotfix?
Para dejar un commit de merge visible que documenta el evento de hotfix y mejora la trazabilidad.

### ¿Por qué cherry-pick en la feature?
Porque quería traer solo el fix puntual sin mezclar otros cambios de main.

### ¿Por qué Merge commit en el PR (no squash)?
Porque el TP pedía commits atómicos y con merge commit quedan preservados en el historial de main.