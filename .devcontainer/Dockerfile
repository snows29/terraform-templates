FROM mcr.microsoft.com/devcontainers/base:ubuntu

USER root
RUN apt-get update && apt-get install -y curl unzip

# Dockerビルド時のターゲットアーキテクチャ（amd64 または arm64）を自動取得
ARG TARGETARCH

# Terraformのインストール（TARGETARCHで動的に切替）
RUN curl -sSL "https://releases.hashicorp.com/terraform/1.14.9/terraform_1.14.9_linux_${TARGETARCH}.zip" -o tf.zip \
    && unzip tf.zip \
    && mv terraform /usr/local/bin/ \
    && rm tf.zip

# AWS CLIのインストール（amd64ならx86_64、arm64ならaarch64に変換して切替）
RUN if [ "$TARGETARCH" = "arm64" ]; then AWS_ARCH="aarch64"; else AWS_ARCH="x86_64"; fi \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip