# Use official Python image (3.10 or 3.11 is safest; avoid 3.13 for now)
FROM python:3.11-slim

# Install system dependencies, including libglib2.0-0 for OpenCV
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy rest of the code
COPY . .

# Expose Cloud Run port
EXPOSE 8080

# Streamlit-specific config (optional: avoid using browser, etc.)
ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS=false

# Set Streamlit to listen on all interfaces and Cloud Run port
CMD ["streamlit", "run", "app.py", "--server.port=8080", "--server.address=0.0.0.0"]
=======
FROM python:3.10-slim

WORKDIR /app

# Install OS-level dependencies for scientific Python
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . .

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
>>>>>>> cc4767b (Initial commit)
