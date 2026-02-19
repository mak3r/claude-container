FROM node:trixie-slim

RUN apt update -y && apt upgrade -y

RUN apt install -y git ripgrep gh

RUN npm install -g @anthropic-ai/claude-code

# install vim because sometimes you need an editor
RUN apt install -y vim
# install a browser to streamline login to claude
RUN apt install -y chromium libcanberra-gtk3-0 

COPY ./chromium.desktop /usr/share/applications/chromium.desktop

# install kubectl
RUN apt install -y apt-transport-https ca-certificates curl gnupg
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly
RUN apt update -y
RUN apt install -y kubectl

ENTRYPOINT [ "/bin/bash" ]

