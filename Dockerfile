FROM python:3.10-slim

# Instalar utilidades necesarias
RUN apt-get update && \
    apt-get install -y --no-install-recommends adduser ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Crear usuario no root
RUN adduser --disabled-password --gecos "" app

# Crear directorio de trabajo y de mlruns con permisos adecuados
WORKDIR /app
RUN mkdir -p /mlruns && chown -R app:app /mlruns

# Copiar dependencias e instalar
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copiar el script de entrenamiento
COPY train.py .

# Cambiar a usuario no root
USER app

# Test:
# CMD ["python", "train.py"]
