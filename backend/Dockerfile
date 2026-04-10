# Backend Dockerfile
FROM node:18

WORKDIR /app

# install dependencies
COPY package*.json ./
RUN npm install

# copy code
COPY . .

# expose backend port
EXPOSE 5000

# start server
CMD ["npm", "start"]