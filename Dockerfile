# 1. Base Image
FROM node:18-slim

# 2. Set working directory
WORKDIR /usr/src/app

# 3. Copy API files and install
COPY api/package*.json ./api/
RUN cd api && npm install

# 4. Copy React files and install
COPY my-app/package*.json ./my-app/
RUN cd my-app && npm install

# 5. Copy the rest of the source code
COPY . .
ENV NODE_OPTIONS=--openssl-legacy-provider
# 6. Build the React app (if needed)
RUN cd my-app && npm run build

# 7. Expose the port your server runs on (usually 3080 or 5000)
EXPOSE 3080

# 8. Start the application
CMD ["node", "./api/server.js"]
