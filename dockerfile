# ── STAGE 1: BUILD STAGE ──────────────────
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy all source files
COPY . .

# Optional: Add any build steps here
# e.g. minify HTML/CSS/JS if needed
RUN echo "Build stage complete"

# ── STAGE 2: PRODUCTION STAGE ─────────────
FROM nginx:1.27-alpine AS production

# Add metadata labels
LABEL maintainer="candb.driver@gmail.com"
LABEL version="1.0"
LABEL description="Best Acting Drivers Website"
LABEL org.opencontainers.image.source="https://github.com/chandrud171989-collab/mywebpage"

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy files from builder stage
COPY --from=builder /app/index.html /usr/share/nginx/html/
COPY --from=builder /app/style.css /usr/share/nginx/html/
COPY --from=builder /app/script.js /usr/share/nginx/html/
COPY --from=builder /app/logo.png /usr/share/nginx/html/

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user for security
RUN addgroup -g 1001 -S nginx-user && \
    adduser -S -D -H -u 1001 -h /var/cache/nginx -s /sbin/nologin -G nginx-user -g nginx-user nginx-user && \
    chown -R nginx-user:nginx-user /usr/share/nginx/html && \
    chown -R nginx-user:nginx-user /var/cache/nginx && \
    chown -R nginx-user:nginx-user /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx-user:nginx-user /var/run/nginx.pid

# Switch to non-root user
USER nginx-user

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s \
            --timeout=10s \
            --start-period=5s \
            --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80 || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]