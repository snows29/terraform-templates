FROM mcr.microsoft.com/devcontainers/base:ubuntu

USER root
RUN apt-get update && apt-get install -y curl unzip

# Dockerビルド時のターゲットアーキテクチャ
ARG TARGETARCH

# Terraformのインストール
RUN curl -sSL "https://releases.hashicorp.com/terraform/1.14.9/terraform_1.14.9_linux_${TARGETARCH}.zip" -o tf.zip \
    && unzip tf.zip \
    && mv terraform /usr/local/bin/ \
    && rm tf.zip

# AWS CLIのインストール
RUN if [ "$TARGETARCH" = "arm64" ]; then AWS_ARCH="aarch64"; else AWS_ARCH="x86_64"; fi \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip