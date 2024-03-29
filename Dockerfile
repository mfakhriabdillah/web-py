FROM python:3.10-alpine3.19
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src src
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=5 CMD \
    wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1
ENTRYPOINT [ "python", "./src/app.py" ]