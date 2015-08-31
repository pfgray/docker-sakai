export JAVA_OPTS="-server -Xmx1028m -XX:MaxMetaspaceSize=512m -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false -Djava.awt.headless=true -Dcom.sun.management.jmxremote"

/tomcat/bin/startup.sh && tail -f /tomcat/logs/catalina.out
