FROM ruby:3.4-bookworm

RUN apt-get update \
    && apt-get install -y --no-install-recommends iproute2 tcpdump iptables \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "infinity"]
