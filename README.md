# Basic MLflow Docker Serving

Este proyecto demuestra cómo entrenar, registrar y servir un modelo de machine learning utilizando MLflow dentro de un entorno Dockerizado. Es útil para quienes desean aprender a implementar un flujo de trabajo completo de ML en un entorno reproducible y portable.

## Características

- Entrenamiento de un modelo de regresión con scikit-learn
- Registro del modelo con MLflow Tracking
- Servir el modelo como API REST mediante MLflow Models
- Entorno reproducible con Docker y Docker Compose

## Estructura del Proyecto


.\
├── Dockerfile\
├── docker-compose.yml\
├── environment.yml\
├── requirements.txt\
├── train.py\
├── mlruns/\
└── README.md


## Requisitos

- Docker
- Docker Compose

## Instrucciones

### 1. Clonar el repositorio

```bash
git clone https://github.com/AlvaroRama/Basic_MLflow_docker_serving.git
cd Basic_MLflow_docker_serving
```

### 2. Construir y levantar los contenedores

```bash
docker compose up --build
```

- Esto lanzará el servidor de MLflow en http://localhost:5000.

### 3. Entrenar y registrar el modelo

- Ejecuta el script de entrenamiento dentro del contenedor:

```bash
docker exec -it basic_mlflow_docker_serving-mlflow-1 python train.py
```

- Esto generará una ejecución con un modelo registrado en el directorio mlruns.

### 4. Servir el modelo como API REST

-Una vez entrenado el modelo, puedes obtener su run_id desde la interfaz de MLflow. Luego, ejecuta:

```bash
mlflow models serve -m runs:/<run_id>/model --no-conda -p 1234
```

- Reemplaza <run_id> por el identificador correspondiente.

### 5. Realizar inferencias

-Envía una petición curl como la siguiente:

```bash
curl -X POST http://localhost:1234/invocations \
  -H "Content-Type: application/json" \
  -d '{
        "dataframe_split": {
          "columns": ["MedInc","HouseAge","AveRooms","AveBedrms","Population","AveOccup","Latitude","Longitude"],
          "data": [[8.3252,41.0,6.9841,1.0238,322.0,2.5556,37.88,-122.23]]
        }
      }'
```
- Notas:
Asegúrate de que los puertos 5000 y 1234 estén libres en tu máquina.

El archivo environment.yml define las dependencias necesarias para reproducir el entorno de entrenamiento en tu máquina local para pruebas
