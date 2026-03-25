FROM openjdk:17
WORKDIR /app
COPY Hello.class .
CMD ["java", "Hello"]
