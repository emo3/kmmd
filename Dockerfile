# Use a specific version of Ubuntu
FROM ubuntu:24.04

# Set the time zone
ENV TZ=America/New_York

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages and preconfigure tzdata
RUN echo "America/New_York" > /etc/timezone && \
    apt-get update && apt-get install -y \
    tzdata \
    kmymoney \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the entry point to KMyMoney
ENTRYPOINT ["kmymoney"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD pgrep kmymoney || exit 1
