FROM node:20

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

# Expose port 3000 and run the app
EXPOSE 3000
CMD ["npm", "start"]

