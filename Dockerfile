FROM tjlaekem/rudder-api:base
COPY . /app
WORKDIR /app
ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 80
CMD make run
