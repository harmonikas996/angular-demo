# Stage 1: Compile and Build Angular Project
FROM node:16-alpine as build

# Set the working directory
WORKDIR /app

# Add dependencies
COPY package.json package-lock.json ./

# Install all the dependencies (without dev dependencies)
RUN npm ci --production && npm cache clean --force

# Add the source code to app
COPY . .

# Generate the build of the application
RUN npm run build --prod

# Stage 2: Serve app with nginx server
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=build /app/dist/angular-demo/* /usr/share/nginx/html/

# Copy nginx configuration
COPY ./nginx/conf.d/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80