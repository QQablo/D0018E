FROM node:22

# Create app directory in container
WORKDIR /app 

# Install app dependencies and also dev dependencies
COPY package*.json ./ 

RUN npm install --include=dev

# Copy app files to container
COPY . .

# Expose the listening port
EXPOSE 3000

# Development
CMD ["npm", "run", "start"] 

# Production
# CMD ["npm", "run", "serve"]  