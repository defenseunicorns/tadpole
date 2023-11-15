exec uvicorn main:app --proxy-headers --host 0.0.0.0 --port 8080 --app-dir ./api/* &
find backend/* -name "main.py" -execdir python {} \;