# Ubuntu Docker image and install KMyMoney

## Steps to Install KMyMoney on an ubuntu Docker Image

This will create a docker container with just KMyMoney installed.

- As of 06/25/2025
  - ubuntu:latest => 24.04.2 LTS
  - kmymoney => 5.1.3-1build15
- Create a Dockerfile: Start by creating a Dockerfile that uses an ubuntu base image.
- Install Required Packages: You will need to install KMyMoney along with its dependencies.
  This typically includes Qt libraries and other KDE components.
- `git clone https://github.com/emo3/kmmd.git`
- `cd kmmd`
- Build the Docker Image: Use the Dockerfile to build your image.

```sh
# Pull the latest Ubuntu image
docker pull ubuntu:latest
# Build the container
docker build -t kmymoney-ubuntu .
```

- Set DISPLAY Variable: Run the following command to set the DISPLAY environment variable
  `export DISPLAY=:0`
- Run the Container: Once the image is built, you can run a container from it.
- Access Control: When you run the Docker container,
  you may need to allow access for the container to connect to XQuartz.
  `xhost + 127.0.0.1`
- Where you store your data **WILL** be different that mine.
  Please remember to replace {YourGDriveEmailHere} with your email connected to Google Drive.
  If you another cloud storage, then suggest changes that you have verified.

The `-v` options allow you to bind local directories on your MacOS with the Docker container.  
For example, to mount your Google Drive and your KMyMoney data directory:

**Note:**  

- Adjust the paths (`${HOME}/Library/CloudStorage/GoogleDrive-{YourGDriveEmailHere}...`) to match your system.
- If you use another cloud storage, replace the path accordingly.

```sh
# Run the container
docker run -it --rm --name kmymoney -d \
    -e DISPLAY=host.docker.internal:0 \
    -e QT_QPA_PLATFORM=xcb \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${HOME}/Library/CloudStorage/GoogleDrive-{YourGDriveEmailHere}:/root/mydata \
    -v ${HOME}/Library/CloudStorage/GoogleDrive-{YourGDriveEmailHere}/My\ Drive/Banks/kmymoney/.config/kmymoney:/root/.config/kmymoney \
    kmymoney-ubuntu
# Shell into container
docker exec -it kmymoney /bin/bash
```

## Other requirements to use this software

### XQuartz/X11 Requirement for Mac Users

Since KMyMoney is a GUI application, you need an X11 server to display the interface on MacOS.  
Install [XQuartz](https://www.xquartz.org/) and start it before running the container.  
You may also need to allow network connections to the X server:

```sh
xhost +
```

### Environment Variables

The following environment variables are used in the Dockerfile:

- `TZ`: Sets the timezone (default: `America/New_York`)
- `DEBIAN_FRONTEND`: Set to `noninteractive` for automated installs

You can override these when running the container:

```sh
docker run -e TZ=Europe/Berlin ...
```

[![Docker Image CI](https://github.com/emo3/kmmd/actions/workflows/docker-image.yml/badge.svg)](https://github.com/emo3/kmmd/actions/workflows/docker-image.yml)
