FROM ubuntu:22.10
RUN apt-get update && apt-get install -y ca-certificates
RUN mkdir /app
COPY ./bin/prometheus-rancher-exporter /app/
WORKDIR /app
RUN chmod +x /app/prometheus-rancher-exporter
CMD ["/app/prometheus-rancher-exporter"]
EXPOSE 8080
