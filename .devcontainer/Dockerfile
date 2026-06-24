FROM mcr.microsoft.com/devcontainers/base:ubuntu

USER root
RUN apt-get update && apt-get install -y curl unzip

# Terraformのインストール（直接バイナリをダウンロード）
RUN curl -sSRC - https://releases.hashicorp.com/terraform/1.14.9/terraform_1.14.9_linux_arm64.zip -o tf.zip \
    && unzip tf.zip \
    && mv terraform /usr/local/bin/ \
    && rm tf.zip

# AWS CLIのインストール（公式のインストールスクリプト）
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip