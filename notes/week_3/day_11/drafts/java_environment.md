Structure created
spring-demo/
├── pom.xml
└── src/main/java/com/demo/DemoApplication.java

The application build

docker run --rm -v "$(pwd)":/app -w /app maven:3.9-eclipse-temurin-17 mvn clean package -DskipTests

After Build Success

docker run --rm -it -p 8080:8080 -v "$(pwd)":/app -w /app eclipse-temurin:17 java -jar target/spring-demo-0.0.1-SNAPSHOT.jar

Erros found

ClassNotFoundException -> class not compiled
Solution: mvn clean package

