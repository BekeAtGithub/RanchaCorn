from fastapi.testclient import TestClient
from app import app

client = TestClient(app)

def test_root_endpoint():
    response = client.get("/")
    assert response.status_code == 200
    assert "hostname" in response.json()
    assert "version" in response.json()

def test_ui_endpoint():
    response = client.get("/ui")
    assert response.status_code == 200
    assert "<html>" in response.text
    assert "<h1>Node-" in response.text
    assert "Version: " in response.text
