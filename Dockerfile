FROM debian:bullseye-slim

# Installer les dépendances de base
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

# Ajouter la clé publique Google pour apt
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

# Ajouter le dépôt Chrome stable
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Installer Google Chrome stable
RUN apt-get update && apt-get install -y google-chrome-stable && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Définir une commande par défaut pour tester le headless
CMD ["google-chrome-stable", "--headless", "--no-sandbox", "--disable-gpu", "--remote-debugging-port=9222", "https://example.com"]
