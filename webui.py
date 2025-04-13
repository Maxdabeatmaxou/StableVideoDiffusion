import gradio as gr
import os

def generate(input_img):
    input_path = "/app/svd/inputs/input.png"
    output_path = "/app/svd/outputs/generated.mp4"

    input_img.save(input_path)
    os.system(f"python3 /app/svd/inference.py --input {input_path} --output {output_path}")
    return output_path

with gr.Blocks() as demo:
    gr.Markdown("# 🎞️ Stable Video Diffusion")
    with gr.Row():
        input_img = gr.Image(label="Image de départ", type="pil")
        video_out = gr.Video(label="Vidéo générée")
    run_btn = gr.Button("Générer")
    run_btn.click(fn=generate, inputs=[input_img], outputs=[video_out])

demo.launch(server_name="0.0.0.0", server_port=7860)