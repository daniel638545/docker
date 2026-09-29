# # Use Node.js as the base image
# FROM node:18

# # Set the working directory inside the container
# WORKDIR /app

# # Copy package.json and package-lock.json files
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Generate Database
# RUN npx prisma migrate dev --name init

# # Build the Next.js application
# RUN npm run build

# # Expose the port the app runs on
# EXPOSE 3000

# # Start the Next.js application
# CMD ["npm", "start"]


FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache openssl libc6-compat

COPY package*.json ./

RUN npm ci

COPY . .

# Generowanie Prisma Client
RUN npx prisma generate

# Budowanie Next.js
RUN npm run build

EXPOSE 3000

CMD ["sh", "-c", "npx prisma migrate deploy && npm start"]