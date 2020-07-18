FROM ruby:2.6.3
COPY . /app
WORKDIR /app
RUN make install
ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 80
CMD make run
