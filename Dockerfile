# Use Google's official Playwright image for absolute compatibility
FROM mcr.microsoft.com/playwright:v1.42.0-jammy

# Set working directory
WORKDIR /app

# Install Node.js and Xvfb
RUN apt-get update && apt-get install -y curl xvfb && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Python and Pip
RUN apt-get update && apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install dependencies
RUN npm install
RUN pip3 install -r requirements.txt

# Create profile directory and set permissions
RUN mkdir -p /app/browser_profile && chmod +x /app/start.sh

# Expose port
EXPOSE 3005

# Start the server using the shell script
CMD ["/bin/bash", "/app/start.sh"]
