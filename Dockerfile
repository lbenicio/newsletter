# Stage 1 — build the site
FROM golang:1.26.4-bookworm AS build

ARG HUGO_VERSION=0.168.0
ARG HUGO_SHA256_AMD64=787f100057328824f38c6ad7c87ff10d6451ae0a7bc39cedaad0dd2bcde17e53
ARG HUGO_SHA256_ARM64=b975ba150a464f57115bdf6cbf6638224906461fdcf863821ec983f8602a442c
ARG TARGETARCH

# Install the same Hugo Extended release used by the deployment workflow.
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git libstdc++6 tar \
    && rm -rf /var/lib/apt/lists/* \
    && case "${TARGETARCH}" in \
         amd64) HUGO_SHA256="${HUGO_SHA256_AMD64}" ;; \
         arm64) HUGO_SHA256="${HUGO_SHA256_ARM64}" ;; \
         *) echo "Unsupported target architecture: ${TARGETARCH}" >&2; exit 1 ;; \
       esac \
    && curl --fail --silent --show-error --location \
      "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz" \
      --output /tmp/hugo.tar.gz \
    && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
    && tar -xzf /tmp/hugo.tar.gz -C /usr/local/bin hugo \
    && rm /tmp/hugo.tar.gz

# Allow Go to fetch the version required by go.mod if it is newer than the image toolchain.
ENV GOTOOLCHAIN=auto

RUN hugo version && go version

WORKDIR /src

COPY . .

# Download Hugo modules
RUN hugo mod get

RUN hugo --minify --environment production --cleanDestinationDir
RUN GOPROXY=direct go run github.com/lbenicio/aboutme-v2-theme/cmd/obfuscate@v0.4.4 ./public || true

# Stage 2 — serve
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY --from=build /src/public .

EXPOSE 80
