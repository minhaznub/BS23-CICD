import requests

def get_weather(city="dhaka"):
    try:
        # Open-Meteo API for simplicity (no key required)
        params = {
            "latitude": 23.8103,
            "longitude": 90.4125,
            "current_weather": True
        }
        response = requests.get("https://api.open-meteo.com/v1/forecast", params=params, timeout=3)
        response.raise_for_status()
        data = response.json()
        temp = data.get("current_weather", {}).get("temperature", "N/A")
        return {
            "temperature": str(temp),
            "temp_unit": "c"
        }
    except Exception as e:
        return {
            "temperature": "N/A",
            "temp_unit": "c",
            "error": str(e)
        }
