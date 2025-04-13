FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Install system tools and Python
RUN apt-get update && apt-get install -y git wget curl python3 python3-pip ffmpeg libgl1 libglib2.0-0 && apt-get clean
RUN pip3 install --upgrade pip

# Clone SVD repo
RUN git clone https://github.com/Stability-AI/stable-video-diffusion.git svd
WORKDIR /app/svd

# Install core dependencies
RUN pip3 install -r requirements.txt
RUN pip3 install diffusers transformers accelerate scipy imageio moviepy gradio fastapi uvicorn

# Create folders
RUN mkdir -p /app/svd/models /app/svd/outputs /app/svd/api

# Copy in the startup + API + UI
COPY startup.sh /app/startup.sh
COPY app.py /app/app.py
COPY webui.py /app/webui.py

RUN chmod +x /app/startup.sh
CMD ["/bin/bash", "/app/startup.sh"]