FROM node:trixie-slim

RUN apt update -y && apt upgrade -y

RUN apt install -y git ripgrep gh

RUN npm install -g @anthropic-ai/claude-code

# install a browser to streamline login to claude
RUN apt install -y chromium libcanberra-gtk3-0 vim

COPY ./chromium.desktop /usr/share/applications/chromium.desktop


ENTRYPOINT [ "/bin/bash" ]

