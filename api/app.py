from flask import Flask, jsonify
from datetime import datetime
import socket
from weather import get_weather
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)

# Enable Prometheus metrics collection
metrics = PrometheusMetrics(app)
metrics.info('flask_app_info', 'Flask Weather App')

def read_version():
    with open("version.txt", "r") as f:
        return f.read().strip()

@app.route("/api/hello", methods=["GET"])
def hello():
    return jsonify({
        "hostname": socket.gethostname(),
        "datetime": datetime.now().strftime("%y%m%d%H%M"),
        "version": read_version(),
        "weather": {
            "dhaka": get_weather()
        }
    })

@app.route("/api/health", methods=["GET"])
def health():
    weather = get_weather()
    if weather.get("temperature") != "N/A":
        return jsonify({"status": "healthy", "weather_api": "reachable"}), 200
    return jsonify({"status": "degraded", "weather_api": "unreachable"}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
