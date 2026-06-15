# Stage 1: Build the React application
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Serve the application using Nginx
FROM nginx:stable-alpine AS runner
# Copy the compiled production build from Stage 1 to Nginx default public directory
COPY --from=builder /app/dist /usr/share/nginx/html
# Copy your custom Nginx configuration for correct single-page routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]