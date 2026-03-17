# Use Google's official Playwright image for absolute compatibility
FROM mcr.microsoft.com/playwright:v1.42.0-jammy

# Set working directory
WORKDIR /app

# Install Node.js
RUN apt-get update && apt-get install -y curl xvfb && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install Python and Pip
RUN apt-get install -y python3 python3-pip

# Copy project files
COPY . .

# Install dependencies
RUN npm install
RUN pip3 install -r requirements.txt

# Create profile directory
RUN mkdir -p /app/browser_profile

# Expose port
EXPOSE 3005

# Start the server with a virtual display for extension support
CMD ["xvfb-run", "--server-args=-screen 0 1280x1024x24", "node", "scraper_server.js"]
