# Phase 1 - Build
# everything from the build phase will be removed
# FROM node:alpine AS builder
FROM node:alpine

WORKDIR '/usr/react-app'

COPY ./frontend/package.json .
RUN npm install

COPY ./frontend .

# we just need the index.html and main.js files from the build folder
# /usr/react-app/build
RUN npm run build

# Phase 2 - Run
# FROM statement separates each phase or block
FROM nginx
# travis-ci wil use this instruction to open the port in the elastic beanstalk environment
EXPOSE 80
# COPY --from=builder /usr/react-app/build /usr/share/nginx/html
COPY --from=0 /usr/react-app/build /usr/share/nginx/html

# the default command of nginx command is start nginx, we don't need to specify a default CMD
