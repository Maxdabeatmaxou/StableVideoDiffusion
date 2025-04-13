from fastapi import FastAPI, UploadFile, File
from fastapi.responses import FileResponse
import shutil
import os

app = FastAPI()

@app.post("/video")
async def generate_video(image: UploadFile = File(...)):
    input_path = "/app/svd/inputs/input.png"
    output_path = "/app/svd/outputs/generated.mp4"
    
    with open(input_path, "wb") as buffer:
        shutil.copyfileobj(image.file, buffer)

    os.system(f"python3 /app/svd/inference.py --input {input_path} --output {output_path}")
    return FileResponse(output_path, media_type="video/mp4", filename="generated.mp4")