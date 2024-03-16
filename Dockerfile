# using multi stage build
FROM node:latest AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Next.js app
RUN npm run build


# Start a new stage for serving the app
FROM node:alpine


WORKDIR /app

# Copy built files from previous stage
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/package.json ./

# Install production dependencies
RUN npm install --production

# Expose the port Next.js is running on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
