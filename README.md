# Virtual environment for PhDSeeker based on Python 3.6 #

## Description ##
This is a Docker image with Python 3.6. The Python version is the one included in Ubuntu 16.04. In addition, it contains several Python packages installed (you can get more details by inspecting the [Dockerfile](https://github.com/mgerard/phdseeker3/blob/master/Dockerfile)):

## Web demo builder ##
This Docker image is also used by the Web demo builder as the Python 3 *virtual environment*. You don't need to download it or use it directly from here, just use the Web demo builder interface, select the Python programming language and this virtual environment will be automatically used.

## Showing figures and plots ##
If you want to use this image as your virtual environment for your Python 3 code (without using the Web demo builder), you might want to be able to show figures and plots within it. For this, you need to run your container with some special parameters. These parameters allows the Python process inside to get access to your X11 session.

    #!bash
    sudo docker run -ti -e DISPLAY=$DISPLAY -e uid=$UID \
      -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
      mfgerard/cariopynet

Once inside the container, you will see a shell prompt like this:

    #!bash
    developer@CONTAINER_ID:/$

where CONTAINER_ID is a unique identifier of this container (you can get this ID by running `sudo docker ps`). You can use this identifier to control your container and, in those cases, the first four characters are usually enough.
