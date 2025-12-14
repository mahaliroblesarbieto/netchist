# Build-less Dockerfile for NetBeans/Ant web app using existing build/web artifacts
# Runtime: Tomcat 10 (Jakarta), Java 17
FROM tomcat:10.1-jdk17-temurin

# Set working dir
WORKDIR /usr/local/tomcat

# Copy built webapp (exploded) into ROOT application
# Ensure your repo includes build/web from NetBeans build. If not, run Clean and Build locally first.
COPY build/web/ /usr/local/tomcat/webapps/ROOT/

# Add entrypoint to rewrite server.xml connector port to Railway's $PORT
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Default Tomcat port (Railway will set PORT). Expose for local runs.
EXPOSE 8080

# Start Tomcat via our entrypoint which adjusts the port
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["catalina.sh", "run"]
