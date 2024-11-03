from fastapi import FastAPI
import os

app = FastAPI()

# Get instance suffix and version from environment variables, default values provided
INSTANCE_SUFFIX = os.getenv("INSTANCE_SUFFIX", "01")
VERSION = "1.0"

@app.get("/")
async def root():
    hostname = f"Node-{INSTANCE_SUFFIX}"
    return {"hostname": hostname, "version": VERSION}

@app.get("/ui")
async def display_ui():
    hostname = f"Node-{INSTANCE_SUFFIX}"
    html_content = f"""
    <html>
        <head><title>Uvicorn Web App</title></head>
        <body>
            <h1>{hostname}</h1>
            <p>Version: {VERSION}</p>
        </body>
    </html>
    """
    return html_content
