
# Use a slim Python image for faster, smaller builds
FROM python:3.11-slim

# Install system dependencies needed for scientific computing and OpenCV
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy requirements first (for Docker cache optimization)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app's code (including app.py, model code, etc.)
COPY . .

# Expose the port Cloud Run expects
EXPOSE 8080

# Optional: Streamlit config to reduce telemetry/noise
ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS=false

# Run Streamlit on the port Cloud Run provides (8080), on all network interfaces
CMD ["streamlit", "run", "app.py", "--server.port=8080", "--server.address=0.0.0.0"]

# Use a slim Python image for faster, smaller builds
FROM python:3.11-slim

# Install system dependencies needed for scientific computing and OpenCV
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy requirements first (for Docker cache optimization)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app's code (including app.py, model code, etc.)
COPY . .

# Expose the port Cloud Run expects
EXPOSE 8080

# Optional: Streamlit config to reduce telemetry/noise
ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS=false

# Run Streamlit on the port Cloud Run provides (8080), on all network interfaces
CMD ["streamlit", "run", "app.py", "--server.port=8080", "--server.address=0.0.0.0"]

