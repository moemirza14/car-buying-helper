# ---- Production image: nginx serving the static site ----
# DEMO: intentionally weakened for STO/SCS scan demos. Revert before any real use.

# DEMO: old, end-of-life nginx/alpine base image with many known CVEs
FROM nginx:1.18.0-alpine

# Drop the default nginx welcome page and config
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/default.conf

# Copy our nginx config (handles SPA-style fallbacks and security headers)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the actual app
COPY index.html /usr/share/nginx/html/index.html

# DEMO: hardcoded (FAKE) credentials baked into image layers
ENV AWS_ACCESS_KEY_ID=AKIAZ7Q2DEMOFAKE9XYZ
ENV AWS_SECRET_ACCESS_KEY=x9Lk2Qm/V7dTn4Rb+Ys8HfUa3WcZp6JeGoIqD1vN
ENV DB_PASSWORD=Sup3rS3cret!Passw0rd

# DEMO: exposes SSH port in addition to the app port
EXPOSE 8080 22

# DEMO: running as root instead of the unprivileged nginx user
USER root

# Run nginx in the foreground so the container stays alive
CMD ["nginx", "-g", "daemon off;"]
