# Use a specific version of Ubuntu
# FROM ubuntu:22.04
FROM ubuntu:latest

# Set the time zone
ENV TZ=America/New_York

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages and preconfigure tzdata
RUN echo "America/New_York" > /etc/timezone && \
    apt-get update && apt-get install -y \
    tzdata \
    kmymoney \
    qtbase5-dev \
    qtdeclarative5-dev \
    libqt5svg5-dev \
    qttools5-dev-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the entry point to KMyMoney
ENTRYPOINT ["kmymoney"]
