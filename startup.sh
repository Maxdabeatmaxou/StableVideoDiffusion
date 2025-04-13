#!/bin/bash
echo "📦 Téléchargement du modèle Stable Video Diffusion..."
cd /app/svd/models
wget -O svd-model.safetensors https://huggingface.co/stabilityai/stable-video-diffusion-img2vid/resolve/main/svd.safetensors

echo "✅ Modèle téléchargé. Démarrage de l'API et de l'interface..."
# Lance l'API et l'interface en parallèle
cd /app
nohup python3 app.py &
python3 webui.py