This is a simple FastAPI app that:

    Returns a JSON response with hostname and version when you access the root (/) endpoint.
    Displays a basic HTML UI with the hostname and version when you access the /ui endpoint

requirements.txt file installs
fastapi: The web framework.
uvicorn: The ASGI server to run the FastAPI app.

Dockerfile details:
FROM python:3.10-slim: Uses a lightweight Python 3.10 image.
WORKDIR /app: Sets /app as the working directory.
COPY requirements.txt .: Copies requirements.txt into the container.
RUN pip install --no-cache-dir -r requirements.txt: Installs dependencies.
COPY . .: Copies the entire app code into the container.
EXPOSE 8000: Exposes port 8000 for the FastAPI app.
CMD: Specifies the command to run the app using Uvicorn.

the /test/test-app.py:
FastAPI TestClient: Used to test FastAPI apps. It provides methods to send HTTP requests to the app and check the responses.
test_root_endpoint: Tests the / endpoint, ensuring it returns a 200 OK status and the expected JSON structure.
test_ui_endpoint: Tests the /ui endpoint, checking for a 200 OK status and that the HTML response includes specific content.

