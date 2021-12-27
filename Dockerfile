# Use official node image as the base image
FROM node:16 as build

# Set the working directory
WORKDIR /usr/local/app

# Add dependencies
COPY package.json package-lock.json ./

# Install all the dependencies (without dev dependencies)
RUN npm ci --production && npm clean cache --force

# Add the source code to app
COPY . ./

# Generate the build of the application
RUN npm run build --production