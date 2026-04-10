# Frontend Dockerfile
FROM node:22-alpine 

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# build Vite app
RUN npm run build

EXPOSE 5173

CMD ["npm", "run", "preview", "--", "--port", "5173", "--host"]