FROM python:3.11-slim
WORKDIR /app
COPY app/ .
RUN pip install --no-cache-dir -r requirement.txt
EXPOSE 5000
CMD ["python", "app.py"]