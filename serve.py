from http.server import HTTPServer, SimpleHTTPRequestHandler
import os

# Ensure we serve from the build directory
os.chdir("build/web")

# Comma-separated list of allowed origins for CORS.
# Defaults keep local development working while avoiding wildcard CORS.
ALLOWED_ORIGINS = {
    origin.strip()
    for origin in os.getenv(
        "ALLOWED_ORIGINS",
        "http://localhost:8000,http://127.0.0.1:8000"
    ).split(",")
    if origin.strip()
}

class CORSRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        # Required for Godot 4 SharedArrayBuffer support
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")

        origin = self.headers.get("Origin")
        if origin in ALLOWED_ORIGINS:
            self.send_header("Access-Control-Allow-Origin", origin)
            self.send_header("Vary", "Origin")

        SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    port = 8000
    print(f"Serving Godot project at http://localhost:{port}")
    HTTPServer(('', port), CORSRequestHandler).serve_forever()