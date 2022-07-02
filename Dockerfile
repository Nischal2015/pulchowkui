FROM node:18-alpine3.16 AS build

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

# Production build
FROM node:18-alpine3.16

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package*.json ./
COPY --from=build /app/.next ./.next

EXPOSE 3000

CMD ["npm", "start"]

