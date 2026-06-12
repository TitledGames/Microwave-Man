from http.server import HTTPServer, SimpleHTTPRequestHandler
import os

# Ensure we serve from the build directory
os.chdir("build/web")

class CORSRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        # Required for Godot 4 SharedArrayBuffer support
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")

        # Restrict CORS to local development origins.
        origin = self.headers.get("Origin")
        allowed_origins = {
            "http://localhost:8000",
            "http://127.0.0.1:8000",
        }
        if origin in allowed_origins:
            self.send_header("Access-Control-Allow-Origin", origin)
            self.send_header("Vary", "Origin")

        SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    port = 8000
    print(f"Serving Godot project at http://localhost:{port}")
    HTTPServer(('', port), CORSRequestHandler).serve_forever()