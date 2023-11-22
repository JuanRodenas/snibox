# snibox
Gestor de fragmentos de código auto-alojado. Desarrollado para recoger y organizar fragmentos de código utilizando Sqlite como base de datos.

[![GitHub](https://img.shields.io/static/v1.svg?color=blue&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=JuanRodenas&message=GitHub&logo=github)](https://github.com/JuanRodenas "view the source for all of our repositories.")
![Docker Pulls](https://img.shields.io/docker/pulls/juanico/snibox?logo=docker&style=for-the-badge)
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/juanico/snibox?logo=docker&style=for-the-badge)

## Construir
Las arquitecturas soportadas por esta imagen son:

| PROYECTO | TAGNAME  | COMMENT |
| :-- | :--: | :-- |
| estable | :stable | Version stable |
| arm | :arm | Version armv8 |
---

## Usage
* Realiza un pull con la imagen: 
`docker pull juanico/snibox:stable`

* Docker compose:
```bash
---
version: '3'
services:
  snibox:
    container_name: snibox
    volumes:
        - '/patch/to/data/app/db:/app/db/database'
    ports:
        - '3000:3000'
    restart: always
    image: juanico/snibox:stable
    env_file:
        - .env
    security_opt:
        - no-new-privileges:true
```
El contenedor ejecuta `rake db:migrate` en cada inicio, para crear el archivo de la base de datos si no existe, o actualizar el esquema de la base de datos si es necesario, por lo que las copias de seguridad son muy recomendables.

### Environment variables
`DATABASE` - Define la ubicación del archivo de la base de datos sqlite3 dentro del contenedor.

_Default_: `/app/db/database/snibox.sqlite3`

---

`SECRET_KEY_BASE` - Define el parámetro `secret_key_base` para tu aplicación Rails. El parámetro por defecto ya está incluido en la imagen, pero la recomendación general es cambiarlo.

---

`LOGLEVEL` - Define el nivel de registro de la aplicación Rails. Las opciones disponibles son: `debug`, `info`, `warn`, `error` and `fatal`
_Default_: `debug`
