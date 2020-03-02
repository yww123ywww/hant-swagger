SERVICE_NAME=${PWD##*/}
JAR=$SERVICE_NAME.jar
MPORT=8051

echo ">>> git pull"
git pull

echo ">>> mvn clean package -Dmaven.javadoc.skip=true"
mvn clean package -Dmaven.javadoc.skip=true

echo ">>> cd target"
cd target
mv app.jar $JAR

echo ">>> kill -9 $(lsof -t -sTCP:LISTEN -i:$MPORT)"
kill -9 $(lsof -t -sTCP:LISTEN -i:$MPORT)

JAVA_OPTS="-Xms512m -Xmx1536m -Dspring.profiles.active=dev"
echo ">>> nohup java -jar $JAVA_OPTS $JAR >app.log &"
BUILD_ID=dontKillMe nohup java -jar $JAVA_OPTS $JAR >app.log &


