FROM nginx:1.26-alpine AS base
WORKDIR /app
RUN rm -rf /usr/share/nginx/html/*
EXPOSE 80

FROM node:20.17.0-alpine AS build
WORKDIR /src
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

FROM base AS final
COPY --from=build /src/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]