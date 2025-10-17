#!/bin/bash
# ============================================================
# Instalar Docker + Docker Compose en Debian 13 (Trixie) - VERSIÓN CORREGIDA
# Maneja específicamente los problemas de sqv y repositorios en Trixie
# ============================================================

set -e  # Salir si cualquier comando falla

echo "============================================================"
echo " Instalador de Docker para Debian 13 (Trixie) - FIJO"
echo "============================================================"

# --- 1. Verificar que estamos en Debian 13 ---
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$VERSION_CODENAME" != "trixie" ]; then
        echo "WARNING: Este script está optimizado para Debian 13 (Trixie)"
        echo "Codename detectado: $VERSION_CODENAME"
    fi
else
    echo "WARNING: No se puede determinar la versión de Debian"
fi

# --- 2. Actualizar sistema ---
echo "==> Actualizando el sistema..."
apt update && apt upgrade -y

# --- 3. Instalar dependencias básicas ---
echo "==> Instalando utilidades básicas..."
apt install -y curl wget ca-certificates lsb-release

# --- 4. Limpiar cualquier configuración previa problemática ---
echo "==> Limpiando configuraciones problemáticas de Docker..."
rm -f /etc/apt/keyrings/docker.gpg*
rm -f /etc/apt/sources.list.d/docker.list*
rm -f /usr/share/keyrings/docker*

# --- 5. Eliminar instalaciones previas ---
echo "==> Eliminando instalaciones previas de Docker..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; do 
    apt remove --purge -y $pkg 2>/dev/null || true
done

# --- 6. Instalar herramientas adicionales ---
echo "==> Instalando herramientas de red y sistema..."
apt install -y sudo net-tools iproute2 iputils-ping bind9-dnsutils

# --- 7. Método alternativo: Instalar Docker desde repos oficiales de Debian ---
echo "==> Intentando instalación desde repositorios oficiales de Debian..."
echo "    (Evitando problemas de sqv con repositorios externos)"

# Actualizar repositorios
apt update

# Verificar si docker.io está disponible
if apt-cache show docker.io >/dev/null 2>&1; then
    echo "==> Instalando Docker desde repositorios Debian (recomendado para Trixie)..."
    apt install -y docker.io docker-compose docker-doc
    
    # Habilitar y iniciar Docker
    systemctl enable docker
    systemctl start docker
    
    # Verificar que funciona
    sleep 3
    if systemctl is-active --quiet docker; then
        echo "==> Docker instalado y funcionando correctamente"
        
        # Configurar grupos de usuario
        echo "==> Configurando permisos de usuario..."
        
        if ! getent group docker >/dev/null; then
            groupadd docker
        fi
        
        # Agregar usuario al grupo docker
        if [ -n "$SUDO_USER" ]; then
            usermod -aG docker $SUDO_USER
            echo "==> Usuario $SUDO_USER agregado al grupo docker"
        elif [ "$USER" != "root" ]; then
            usermod -aG docker $USER
            echo "==> Usuario $USER agregado al grupo docker"
        else
            echo "==> Ejecutándose como root - configurar manualmente el usuario después"
        fi
        
        # Verificar instalación
        echo "==> Verificando instalación..."
        docker --version
        docker compose version || echo "Docker Compose está disponible como 'docker-compose'"
        
        echo "==> Probando Docker con hello-world..."
        docker run hello-world
        
        echo "============================================================"
        echo " ✅ Docker instalado correctamente en Debian 13 (Trixie)"
        echo ""
        echo " 🔄 IMPORTANTE: Cierra sesión y vuelve a entrar para usar"
        echo "    Docker sin sudo (o ejecuta: newgrp docker)"
        echo ""
        echo " 📦 Para instalar Odoo 18 ahora ejecuta:"
        echo "    curl -s https://raw.githubusercontent.com/tomasecastro/odoo-18-docker-compose/master/run.sh | sudo bash -s odoo-one 10018 20018"
        echo "============================================================"
        exit 0
    else
        echo "ERROR: Docker no se pudo iniciar correctamente"
        systemctl status docker --no-pager
        exit 1
    fi
else
    echo "ERROR: docker.io no está disponible en los repositorios"
    exit 1
fi