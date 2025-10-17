#!/bin/bash
# ============================================================
# Instalar Docker + Docker Compose en Debian 13 (Trixie)
# Incluye sudo, net-tools y herramientas de red
# ============================================================

# --- 1. Actualizar sistema ---
echo "==> Actualizando el sistema..."
apt update && apt upgrade -y

# --- 2. Instalar utilidades básicas ---
echo "==> Instalando utilidades necesarias..."
apt install -y sudo curl wget gnupg lsb-release ca-certificates apt-transport-https software-properties-common \
    net-tools iproute2 iputils-ping dnsutils

# --- 3. Crear grupo sudo si no existe ---
if ! getent group sudo >/dev/null; then
  echo "==> Creando grupo sudo..."
  groupadd sudo
fi

# --- 4. Agregar el usuario actual al grupo sudo ---
if [ "$(id -u)" -ne 0 ]; then
  echo "==> Agregando el usuario actual al grupo sudo..."
  sudo usermod -aG sudo $USER
fi

# --- 5. Eliminar versiones antiguas de Docker ---
echo "==> Eliminando posibles instalaciones anteriores de Docker..."
apt remove -y docker docker-engine docker.io containerd runc || true

# --- 6. Agregar clave GPG de Docker ---
echo "==> Agregando clave GPG oficial de Docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# --- 7. Agregar repositorio de Docker ---
echo "==> Agregando repositorio oficial de Docker..."
CODENAME=$(lsb_release -cs)
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $CODENAME stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# --- 8. Instalar Docker y plugins ---
echo "==> Instalando Docker Engine y complementos..."
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# --- 9. Habilitar y arrancar servicio Docker ---
echo "==> Activando y arrancando Docker..."
systemctl enable docker
systemctl start docker

# --- 10. Agregar usuario al grupo docker ---
echo "==> Agregando el usuario al grupo docker..."
usermod -aG docker $SUDO_USER 2>/dev/null || usermod -aG docker $USER

# --- 11. Verificar instalación ---
echo "==> Verificando instalación..."
docker --version
docker compose version

echo "==> Probando Docker con 'hello-world'..."
docker run hello-world

echo "============================================================"
echo " Docker y Docker Compose instalados correctamente en Debian 13"
echo " Recuerda cerrar sesión y volver a entrar para aplicar los grupos."
echo "============================================================"
