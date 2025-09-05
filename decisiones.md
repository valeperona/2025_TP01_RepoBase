# Decisiones del TP01 – Git Básico (2025)

## Configuración inicial
- Se configuró `user.name` y `user.email` para trazabilidad.
- Se estableció `main` como rama principal por convención moderna.
- Se configuró VSCode como editor por comodidad (`core.editor = code --wait`).


## Desarrollo de la funcionalidad
- Se creó la rama `feature/mi-funcionalidad` para aislar el trabajo de `main`.
- Commit 1: `feat(linecount): agrega script para contar líneas`.  
  👉 Commit atómico: solo introduce la funcionalidad mínima.
- Commit 2: `docs(linecount): documenta ejemplo en README`.  
  👉 Commit separado: documentación no mezclada con código.
- Justificación: mantener cambios claros, fáciles de revisar o revertir.
## Hotfix en producción y propagación
- Bug simulado en `main`: commit con texto erróneo en README.
- Hotfix: rama `hotfix/readme-bug`, commit de corrección.
- Integración a `main`: `git merge --no-ff` → deja registro explícito del hotfix.
- Propagación a `feature/mi-funcionalidad`: `git cherry-pick <hash>` del fix.
- Justificación: cherry-pick me permitió traer solo el fix sin arrastrar otros cambios de `main`.

