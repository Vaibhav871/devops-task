# Use an official Node.js image as the base
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install production dependencies
RUN npm install

# Copy the rest of the application files into the container
COPY . .


# Start the application
CMD ["npm", "start"]
