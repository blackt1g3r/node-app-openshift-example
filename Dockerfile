FROM node:18-alpine
RUN mkdir -p /home/node/app/node_modules
WORKDIR /home/node/app
COPY app/package*.json ./
RUN npm install
COPY  app/ .
EXPOSE 8080
CMD [ "node", "app.js" ]