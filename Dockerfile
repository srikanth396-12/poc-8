FROM eclipse-temurin:17-jre
WORKDIR /app
COPY Hello.java .
RUN javac Hello.java
CMD ["java", "Hello"]
