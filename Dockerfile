FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y google-chrome-stable && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Éviter les erreurs liées à XDG_RUNTIME_DIR
ENV XDG_RUNTIME_DIR=/tmp/runtime-dir
RUN mkdir -p /tmp/runtime-dir

# Ouvre le port pour Render
EXPOSE 9222

# Commande qui expose correctement Chrome sur l'interface réseau
CMD ["google-chrome-stable", "--headless", "--no-sandbox", "--disable-gpu", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222", "https://example.com"]
