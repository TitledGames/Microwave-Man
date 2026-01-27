from http.server import HTTPServer, SimpleHTTPRequestHandler
import sys
import os

# Ensure we serve from the build directory
os.chdir("build/web")

class CORSRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        # Required for Godot 4 SharedArrayBuffer support
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        self.send_header("Access-Control-Allow-Origin", "*")
        SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    port = 8000
    print(f"Serving Godot project at http://localhost:{port}")
    HTTPServer(('', port), CORSRequestHandler).serve_forever()