# Recetario del equipo

Repositorio de práctica del taller de Git. Cada persona aporta una receta por rama y
pull request; las versiones se publican desde `main` con un tag.

## Recetas

- Arepas (recetas/arepas.md)
- Café (recetas/cafe.md)

## Cómo contribuir

1. Partir de `develop` actualizado: `git switch develop && git pull`.
2. Crear una rama: `git switch -c feature/<nombre>-<receta>`.
3. Añadir la receta en `recetas/` y su línea en la lista de arriba.
4. Commit, push y pull request hacia `develop`, revisado por un compañero.

Las versiones (`release/x.y.z`) y los arreglos urgentes (`hotfix/x.y.z`) se explican en `CHANGELOG.md`.
