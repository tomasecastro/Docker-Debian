# Instalador de Docker + Docker Compose para Debian 13 (Trixie)

Este script automatiza la instalación completa de Docker Engine y Docker Compose en **Debian 13 (Trixie)**, incluyendo utilidades de red y configuración de permisos de usuario.

## 📋 Características principales

- ✅ Instalación automática de Docker Engine y Docker Compose
- ✅ Configuración del grupo `sudo` y permisos de usuario
- ✅ Instalación de herramientas de red esenciales (`net-tools`, `iproute2`, `iputils-ping`, `dnsutils`)
- ✅ Eliminación automática de versiones anteriores de Docker
- ✅ Configuración de repositorios oficiales de Docker
- ✅ Verificación completa de la instalación
- ✅ Prueba automática con contenedor `hello-world`

## 🚀 Instalación rápida

### Opción 1: Descargar y ejecutar manualmente

```bash
# Descargar el script de instalación
curl -O https://raw.githubusercontent.com/tu-usuario/tu-repo/main/install_docker_debian13.sh

# Otorgar permisos de ejecución
chmod +x install_docker_debian13.sh

# Ejecutar con privilegios de administrador
sudo ./install_docker_debian13.sh
```

### Opción 2: Ejecutar directamente desde el repositorio

```bash
curl -s https://raw.githubusercontent.com/tu-usuario/tu-repo/main/install_docker_debian13.sh | sudo bash
```

## 📦 Instalación de Odoo 18 con Docker Compose

Una vez que Docker esté instalado, puedes desplegar **Odoo 18** con un solo comando:

```bash
curl -s https://raw.githubusercontent.com/tomasecastro/odoo-18-docker-compose/master/run.sh | sudo bash -s odoo-one 10018 20018
```

**¿Qué hace este comando?**
- 📥 Descarga e instala automáticamente Odoo 18 con Docker Compose
- 🏷️ Configura el nombre de la instancia como `odoo-one`
- 🌐 Expone la aplicación Odoo en el puerto `10018`
- 🗄️ Configura PostgreSQL en el puerto `20018`

## 🛠️ Componentes instalados

### Utilidades del sistema
- **`sudo`** - Gestión de permisos de administrador
- **`curl` y `wget`** - Herramientas para descargas desde internet
- **`gnupg` y `ca-certificates`** - Manejo de certificados y cifrado
- **`apt-transport-https`** - Transporte seguro para repositorios APT

### Herramientas de red
- **`net-tools`** - Comandos clásicos de red (`ifconfig`, `netstat`, `arp`)
- **`iproute2`** - Herramientas modernas de red (`ip`, `ss`, `tc`)
- **`iputils-ping`** - Utilidad `ping` para pruebas de conectividad
- **`dnsutils`** - Herramientas DNS (`dig`, `nslookup`, `host`)

### Componentes de Docker
- **Docker Engine** - Motor principal de contenedores (última versión estable)
- **Docker Compose Plugin** - Orquestación de aplicaciones multi-contenedor
- **Docker Buildx Plugin** - Constructor avanzado de imágenes
- **Containerd** - Runtime de contenedores de bajo nivel

## 📋 Requisitos del sistema

- **Sistema operativo**: Debian 13 (Trixie)
- **Arquitecturas soportadas**: amd64, arm64, armhf
- **Permisos**: Acceso de usuario root o sudo configurado
- **Red**: Conexión activa a internet para descargar paquetes
- **Espacio en disco**: Mínimo 2GB libres para Docker y dependencias

## 🔧 Instrucciones paso a paso

### 1. Preparación del sistema
```bash
# Actualizar lista de paquetes
sudo apt update

# Descargar el instalador
wget https://raw.githubusercontent.com/tu-usuario/tu-repo/main/install_docker_debian13.sh
```

### 2. Ejecución del instalador
```bash
# Hacer el script ejecutable
chmod +x install_docker_debian13.sh

# Ejecutar la instalación
sudo ./install_docker_debian13.sh
```

### 3. Aplicar cambios de grupo
```bash
# Cerrar sesión completamente
exit

# Volver a iniciar sesión para aplicar los grupos
# Esto es OBLIGATORIO para usar Docker sin sudo
```

## ✅ Verificación de la instalación

Después de reiniciar sesión, ejecuta estas pruebas:

```bash
# 1. Verificar versiones instaladas
docker --version
docker compose version

# 2. Probar funcionamiento básico
docker run hello-world

# 3. Confirmar que funciona sin sudo
docker ps

# 4. Verificar servicios activos
sudo systemctl status docker
```

## 🐳 Comandos esenciales de Docker

### Gestión de contenedores
```bash
# Listar contenedores en ejecución
docker ps

# Listar todos los contenedores (incluso detenidos)
docker ps -a

# Detener un contenedor
docker stop <nombre_contenedor>

# Eliminar un contenedor
docker rm <nombre_contenedor>

# Ver logs de un contenedor
docker logs <nombre_contenedor>

# Acceder al terminal de un contenedor
docker exec -it <nombre_contenedor> bash
```

### Gestión de imágenes
```bash
# Listar imágenes descargadas
docker images

# Descargar una imagen
docker pull <nombre_imagen>

# Eliminar una imagen
docker rmi <nombre_imagen>

# Construir imagen desde Dockerfile
docker build -t mi_imagen .
```

### Mantenimiento del sistema
```bash
# Ver uso de espacio en disco
docker system df

# Limpiar recursos no utilizados
docker system prune

# Limpiar todo (¡cuidado!)
docker system prune -a
```

## 🔍 Solución de problemas comunes

### ❌ Error: "docker: command not found"
```bash
# Verificar si Docker está instalado
which docker

# Si no está, volver a ejecutar el instalador
sudo ./install_docker_debian13.sh
```

### ❌ Error: "permission denied while trying to connect to Docker"
```bash
# Verificar pertenencia al grupo docker
groups $USER

# Si no aparece 'docker', agregarlo manualmente
sudo usermod -aG docker $USER

# ¡IMPORTANTE! Cerrar sesión y volver a entrar
exit
```

### ❌ Docker no inicia automáticamente
```bash
# Habilitar el servicio Docker
sudo systemctl enable docker

# Iniciar el servicio Docker
sudo systemctl start docker

# Verificar el estado
sudo systemctl status docker
```

### ❌ Problemas de conectividad de red
```bash
# Verificar redes de Docker
docker network ls

# Reiniciar Docker completamente
sudo systemctl restart docker

# Verificar configuración de red del sistema
sudo systemctl restart networking
```

### ❌ Espacio en disco insuficiente
```bash
# Ver uso de espacio de Docker
docker system df

# Limpiar contenedores detenidos
docker container prune

# Limpiar imágenes no utilizadas
docker image prune

# Limpiar volúmenes huérfanos
docker volume prune
```

## 📚 Recursos y documentación

### Documentación oficial
- 📖 [Documentación completa de Docker](https://docs.docker.com/)
- 🐋 [Referencia de Docker Compose](https://docs.docker.com/compose/)
- 🐧 [Guía de instalación en Debian](https://docs.docker.com/engine/install/debian/)
- 📋 [Mejores prácticas de Docker](https://docs.docker.com/develop/dev-best-practices/)

### Recursos de Odoo
- 🏢 [Repositorio Odoo 18 Docker Compose](https://github.com/tomasecastro/odoo-18-docker-compose)
- 📘 [Documentación oficial de Odoo](https://www.odoo.com/documentation/18.0/)

### Tutoriales recomendados
- 🎓 [Tutorial básico de Docker](https://docs.docker.com/get-started/)
- 🚀 [Guía de Docker Compose](https://docs.docker.com/compose/gettingstarted/)

## 📝 Licencia y uso

Este proyecto se distribuye bajo la **Licencia MIT**. Puedes usar, modificar y distribuir libremente este código. Consulta el archivo `LICENSE` para más detalles.

## 🤝 Cómo contribuir

¡Las contribuciones son muy bienvenidas! Para colaborar:

1. **Fork** este repositorio
2. **Crea una rama** para tu nueva funcionalidad:
   ```bash
   git checkout -b feature/nueva-funcionalidad
   ```
3. **Realiza tus cambios** y commitéalos:
   ```bash
   git commit -m 'Añadir nueva funcionalidad increíble'
   ```
4. **Sube los cambios** a tu fork:
   ```bash
   git push origin feature/nueva-funcionalidad
   ```
5. **Abre un Pull Request** describiendo tus cambios

### Tipos de contribuciones deseadas:
- 🐛 Corrección de errores
- 📝 Mejoras en la documentación
- ⚡ Optimizaciones de rendimiento
- 🆕 Nuevas funcionalidades
- 🧪 Pruebas adicionales

## 📧 Soporte y contacto

¿Tienes preguntas, problemas o sugerencias?

- 🐛 **Reportar errores**: Abre un [issue](https://github.com/tu-usuario/tu-repo/issues)
- 💡 **Sugerir mejoras**: Usa las [discussions](https://github.com/tu-usuario/tu-repo/discussions)
- 📧 **Contacto directo**: Envía un email o menciona en el issue

---

## 🎉 ¡Instalación completada!

**¡Felicitaciones! Ahora tienes Docker funcionando en Debian 13** 🐋

### Próximos pasos recomendados:
1. 🔄 **Reinicia tu sesión** para aplicar los permisos
2. 🧪 **Prueba Docker** con `docker run hello-world`
3. 📦 **Instala Odoo 18** con el comando curl proporcionado
4. 📖 **Explora la documentación** para aprender más

**¡Disfruta desarrollando con Docker! 🚀**