 FROM node:18-alpine     # Lightweight Node.js 18 on Alpine Linux  
WORKDIR /app            # Set working directory to /app  
COPY app/ .             # Copy application files into container  
RUN npm install         # Install runtime dependencies  
EXPOSE 3000             # Container listens on port 3000  
CMD ["npm", "start"]    # Start the application  
