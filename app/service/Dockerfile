FROM python:3.12-slim

WORKDIR /app
COPY pyproject.toml /app/
RUN pip install --no-cache-dir -U pip && pip install --no-cache-dir .

COPY src/ /app/src
EXPOSE 8080
CMD ["python", "-m", "src.main"]