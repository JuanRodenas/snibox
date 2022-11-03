# Snibox
Gestor de fragmentos de código auto-alojado. Desarrollado para recoger y organizar fragmentos de código utilizando Sqlite como base de datos.

## Construir
Para construir esta imagen utilice el siguiente comando:

```bash
git clone https://github.com/JuanRodenas/Snibox.git
docker build -t snibox .
```

## Usage
* Realiza un pull con la imagen: 
`docker pull melashri/snibox:latest`

* Docker compose:
```bash
version: '3'
services:
    snibox:
        container_name: snibox
        volumes:
            - '/home/user/snibox/app/db:/app/db/database'
        ports:
            - '3000:3000'
        restart: always
        image: melashri/snibox
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
