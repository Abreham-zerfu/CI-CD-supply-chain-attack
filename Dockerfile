FROM python:3
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
# VULN: Secrets in Docker layers
ARG APP_SECRET
ENV APP_SECRET=$APP_SECRET
EXPOSE 5000
CMD ["python", "app.py"]