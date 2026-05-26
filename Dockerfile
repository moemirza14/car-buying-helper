# ---- Production image: nginx serving the static site ----
# Pinned to a specific Alpine-based nginx version for reproducibility
# and small image size (~25MB compressed).
FROM nginx:1.27-alpine

# Drop the default nginx welcome page and config
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/default.conf

# Copy our nginx config (handles SPA-style fallbacks and security headers)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the actual app
COPY index.html /usr/share/nginx/html/index.html
# If you add CSS/JS files later, copy them here too. Example:
# COPY assets/ /usr/share/nginx/html/assets/

# Tell Docker which port the container listens on (documentation only;
# you still need -p when running)
EXPOSE 8080

# Run as non-root for security. Nginx's official image supports this
# by writing PIDs and logs to user-writable paths.
USER nginx

# Run nginx in the foreground so the container stays alive
CMD ["nginx", "-g", "daemon off;"]
