# Stage 1: Build the Vue.js app
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Expose the listening port
EXPOSE 8080
#RUN npm run build

CMD ["npm", "run", "serve"]  