FROM node:18-alpine as build

WORKDIR /app

COPY package*.json /

RUN npm ci

COPY *.* .
COPY .* .

COPY libs/core libs/core

RUN npx ng build core -c=production

FROM build as buildlayout

COPY remotes/layout remotes/layout

RUN npx ng build layout -c=production

FROM build as buildhost

COPY apps/host apps/host

RUN npx ng build host -c=production

FROM nginx:latest as staging

ARG HOSTURL

COPY --from=buildhost /app/dist/host/browser /usr/share/nginx/html
COPY --from=buildlayout /app/dist/layout/browser /usr/share/nginx/html/cdn/layout

# Replace HOSTURL in the manifest file using sed
RUN sed "s|HOSTURL|${HOSTURL}|g" /usr/share/nginx/html/federation.manifest.prod.json > /usr/share/nginx/html/federation.manifest.json

EXPOSE 80