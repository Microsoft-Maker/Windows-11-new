FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

USER root
RUN apt-get update && \
    apt-get install -y qemu-kvm libvirt-clients libvirt-daemon-system \
                       p7zip-full && \
    usermod -aG libvirt vscode

USER vscode
WORKDIR /workspace
