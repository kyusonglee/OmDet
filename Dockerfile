# Use the NVIDIA CUDA base image
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and Python
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y git-lfs && \
    git lfs install

# Clone the repository into the resources folder
RUN git clone https://huggingface.co/omlab/OmDet-Turbo_tiny_SWIN_T resources

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Install detectron2
RUN pip3 install 'git+https://github.com/facebookresearch/detectron2.git'

# Expose the port the app runs on
EXPOSE 8000

# Run the application
CMD ["uvicorn", "run_wsgi:app", "--host", "0.0.0.0", "--port", "8000"] 