
FROM python:3.11-alpine

#for security and performance
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_ENV=production \
    TZ=UTC


WORKDIR /app

RUN apk add --no-cache \
    libffi-dev \
    openssl \
    && pip install --upgrade pip
    
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN adduser -D appuser
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
