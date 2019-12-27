FROM node:carbon
ENV NODE_ENV="development"
ENV Docker_PORT 8080
ENV Service_PORT 8080
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE $Docker_PORT
CMD [ "npm", "start" ]
