# Exporter only. Edit the blog with the official ghost:6 image (see compose.yaml).
# This image does not start Ghost and is not a republish of ghost:6.
FROM node:22-bookworm-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends bash ca-certificates wget \
	&& rm -rf /var/lib/apt/lists/* \
	&& npm install -g ghost-static-site-generator

WORKDIR /opt/ghost-on-github-pages

COPY includes ./includes
COPY scripts ./scripts
COPY compose.yaml ./compose.yaml

RUN chmod +x scripts/export-static.sh scripts/validate-static.sh scripts/compose-setup.sh

LABEL org.opencontainers.image.source="https://github.com/paladini/ghost-on-github-pages" \
	org.opencontainers.image.description="Export a running Ghost blog to static files with gssg. Does not replace the official Ghost image." \
	org.opencontainers.image.licenses="MIT"

ENTRYPOINT ["bash", "/opt/ghost-on-github-pages/scripts/export-static.sh"]
