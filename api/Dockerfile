# Start from minimal, secure base image
FROM python:3.11-alpine

# Set environment variables for security and performance
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_ENV=production \
    TZ=UTC

# Set working directory
WORKDIR /app

# Install only necessary system dependencies (no compilers, no unnecessary tools)
RUN apk add --no-cache \
    libffi-dev \
    openssl \
    && pip install --upgrade pip

# Copy only requirements first for layer caching
COPY requirements.txt .

# Install dependencies securely without caching wheels
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY . .

# Create a non-root user and switch to it
RUN adduser -D appuser
USER appuser

# Expose application port
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
