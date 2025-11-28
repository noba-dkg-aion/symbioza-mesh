ARG SERVICE_DIR

FROM python:3.12-slim AS runtime

ARG SERVICE_DIR

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

ENV SERVICE_DIR=${SERVICE_DIR}

WORKDIR /app

COPY ./modules/${SERVICE_DIR}/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r /tmp/requirements.txt

COPY ./modules/${SERVICE_DIR}/ /app

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
