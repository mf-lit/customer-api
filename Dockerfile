FROM python:3.11-slim as base

ENV PYTHONDONTWRITEBYTECODE 1

COPY requirements.txt /
RUN pip install --no-cache-dir --upgrade pip==23.3.1 && \
    pip install --no-cache-dir -r requirements.txt

## test image

FROM base as test

COPY requirements-dev.txt /
RUN pip install --no-cache-dir -r /requirements-dev.txt && \
    mkdir /app

COPY . /app

WORKDIR /app

## prod image

FROM base as prod

# Create a non-root user for runtime
RUN useradd --create-home appuser
WORKDIR /home/appuser
USER appuser

COPY src/*.py ./

ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "customer_api:app"]