With two stages, in th first one(build) the Dockerfile compile and generate the .jar with Maven

FROM maven:3.9-eclipse-temurin-17 AS build
..
..
RUN mvn clean package -DskipTests

The second stage(runtime), copy only .jar and execute it.

..
..
COPY --from=build /app/target/spring-demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]


Docker-compose.yml

services:
  oracle:
    image: container-registry.oracle.com/database/express:21.3.0-xe
    container_name: oracle-xe
    ports:
      - "1521:1521"
    environment:
      - ORACLE_PWD=Oracle123
    networks:
      - pe-net

  app:
    build: .
    container_name: spring-demo
    ports:
      - "8080:8080"
    depends_on:
      - oracle
    networks:
      - pe-net

networks:
  pe-net:
    driver: bridge

---

It starts Oracle abd App together

depends_on -> App will start after Oracle.
Network 'pe-net'-> Allows the App resolve oracle-xe


Useful Commands

docker compose up -d    # start everything in background
docker compose down     # Stop everything
docker compose logs <app>   # Application logs