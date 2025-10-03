import gradio as gr
import argparse

def greet(name):
    return f"Hello, {name}!"

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--server-port", type=str, default="7860")
    parser.add_argument("--server-name", type=str, default="0.0.0.0")
    args = parser.parse_args()

    print(f"Launching Gradio app on {args.server_name}:{args.server_port}")

    iface = gr.Interface(
        fn=greet, 
        inputs="text", 
        outputs="text", 
        title="Greeting App", 
        description="Enter your name to receive a greeting."
    )

    iface.launch(
        server_name=args.server_name,
        server_port=args.server_port,
        share=False
    )
