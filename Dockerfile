FROM golang:1.20-alpine AS build-stage

RUN apk add upx
WORKDIR /src
COPY . .
RUN go build -o /build
RUN upx /build

FROM alpine:latest AS release-stage

COPY --from=build-stage /build /build
# ENV SOME_ENV = ""
# EXPOSE 5000
ENTRYPOINT [ "sh", "-c", "/build" ] # Make sure to edit this