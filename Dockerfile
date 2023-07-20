# Video Annotation Dockerfile
# This file need to be inside this repository, to copy all lib dependencies:
# https://github.com/chinesefirewall/automated_video_annotation_system
# Build command: docker build . -t "videoAnnotation:core"
# Run command: docker run -it --rm -e DISPLAY=${DISPLAY} -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix videoannotation:core
# Ubuntu Version: 16.04
# Python >= 3.8
# OpenCV 4.5.2


# Use Ubuntu 20.04 as base image
FROM ubuntu:20.04

# Set the python version environment variable
ENV PYTHON_VERSION 3.8

# Install system packages and python
RUN apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    build-essential cmake unzip pkg-config \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev \
    libgtk-3-dev \
    libatlas-base-dev gfortran \
    python3.8-dev python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    python3.8 -m pip install --upgrade pip

# Install OpenCV
RUN mkdir /opencv && \
    cd /opencv && \
    wget https://github.com/opencv/opencv/archive/4.5.2.zip && \
    unzip 4.5.2.zip && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D WITH_CUDA=OFF \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D WITH_CUBLAS=1 \
    -D WITH_IPP=ON \
    -D BUILD_EXAMPLES=OFF .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# Clean up the build directory
RUN rm -rf /opencv

# Set the working directory
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Python script into the container
COPY main.py .

# Run the script when the container launches
CMD ["python3.8", "videoAnnotation.py"]
