# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM docker.pkg.github.com/daxiom/gha-test/bcgov-s2i-caddy as prod
RUN mkdir /var/www/html/cooperatives 
COPY --from=build-stage /app/dist /var/www/html/cooperatives
EXPOSE 80
