# Alpine Docker image and install KMyMoney

## Steps to Install KMyMoney on an Alpine Docker Image

- Create a Dockerfile: Start by creating a Dockerfile that uses an Alpine base image.
- Install Required Packages: You will need to install KMyMoney along with its dependencies. This typically includes Qt libraries and other KDE components.
- `cd ~/code/cookbooks/kmmd`
- Build the Docker Image: Use the Dockerfile to build your image.
  `docker build -t kmymoney-ubuntu .`

- Set DISPLAY Variable: Run the following command to set the DISPLAY environment variable
  `export DISPLAY=:0`
- Run the Container: Once the image is built, you can run a container from it.
- Access Control: When you run the Docker container, you may need to allow access for the container to connect to XQuartz.
  `xhost + 127.0.0.1`
- Where you store your data **WILL** be different that mine.
  Please remember to replace {YourGDriveEmailHere} with your email connected to Google Drive.
- The -v options will allow you to bind the local directories on you MacOS with the docker container.

```sh
# Run the container
docker run -it --rm --name kmymoney -d \
    -e DISPLAY=host.docker.internal:0 \
    -e QT_QPA_PLATFORM=xcb \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/Library/CloudStorage/GoogleDrive-{YourGDriveEmailHere}:/root/mydata \
    -v ~/Library/CloudStorage/GoogleDrive-{YourGDriveEmailHere}/My\ Drive/Banks/kmymoney/.config/kmymoney:/root/.config/kmymoney \
    kmymoney-ubuntu
# Shell into
docker exec -it kmymoney /bin/bash
```
