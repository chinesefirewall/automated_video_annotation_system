# Video Annotation

> An automated Video annotation tool built with Python + OpenCV for object detection in YOLO format

![](sampleVid.jpg)

## Output Example

> [See example outputs here](https://drive.google.com/drive/folders/1_tuHCG1-FaILKHlld1vhJ5f-QzRx-Vov?usp=sharing)

## Installation (Tested with Python 3.8 and OpenCV 4.5.2)

```sh
You will need OpenCV with ffmpeg lib

conda create -n videoannotation python=3.8
conda activate videoannotation
conda install -c menpo opencv
pip install --upgrade pip 
pip install opencv-contrib-python

```

## Run with Docker 
### Ubuntu Version: 20.04 / Python 3.8 / OpenCV 4.5.2

 0. You need to install [Docker](https://docs.docker.com/install/) and clone this [project](https://github.com/chinesefirewall/automated_video_annotation_system).
 
 1. Build the docker image. This command only needs to be run once.
			
		docker build . -t "videoAnnotation:core"
 
 2. Make the display exportable

		xhost +local:root

 3. Run and have fun!
	
		docker run -it --rm -e DISPLAY=${DISPLAY} -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix videoannotation:core

 4. To pass data through container -> PC host

 		docker cp <ContainerDockerNumber>:/app/ .

 5. To pass data through PC host -> container (Pass video file to container)

 		docker cp <dataPathInHostPc> <ContainerDockerNumber>:/app/


## Usage example

```sh
python videoAnnotation.py Sorting_Recording.mp4
```

## Controls:

* q - Quit
* Mouse Left - Create new BoundBox, drag to change the dimension
* Mouse Right - Erase actual BoundingBox
* WASD - Move the BoundBox
* 8456 - Change width and height
* Space - Next frame
* Z - Previous 
* 79 - Change current bound box
* '/' or '*' - Change current class
* '-' - Delete the bound box
* R - Get bound box from labels.txt

## Variables -- Trackbar

* ID - Id of the label
* Jump - How many pixels WASD/8456 will change
* Skip - How many frames will be skipped

## Directory Structure
Given a video file, it will create:

```
.
└── VideoFolder (The same name of the video file)
    ├── Ground  (Fold of ground images with BoundBox)
    ├── JPEGImages (Fold of images without BoundBox)
    ├── labels (Fold with the .txt labels files in YOLO format)
 	└──	imgList.txt (List with full directory of images inside JPEGImages folder)
```

### Label Format

    (ID) (absoluteX/imgWidth) (absoluteY/imgHeight) (absoluteWidth/imgWidth) (absoluteHeight/imgHeight)

    Example: 
	  Class Id = 0
	  absoluteX = 50  (X of the center of the BoundBox)
	  absoluteY = 50  (Y of the center of the BoundBox)
	  absoluteWidth = 100 (Width of the BoundBox)
	  absoluteHeight = 100 (Height of the BoundBox)
	  imgWidth = 400  (Image width)
	  imgHeight = 400 (Image Height)

	         0 50/400 50/400 100/400 100/400
	  Label: 0 0.125  0.125   0.25    0.25
	

### TODO
	
	1. Organize the code better
	2. Make automatic BoundBox
	3. A prettier GUI

### Please Feel Free to Contact Me!

**Niyi Adebayo** ([GitHub](https://github.com/chinesefirewall/automated_video_annotation_system))
**adebayoniyi2000@yahoo.com**
