FROM python:3.10.0-alpine3.15

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Install curl
RUN apk add --no-cache curl

# Copy the source code
COPY src src

# Expose port 5000
EXPOSE 5000

# Health check with curl
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=5 \
            CMD curl -f http://localhost:5000/health || exit 1

# Set the entry point
ENTRYPOINT ["python", "./src/app.py", "--port", "5000"]
