# ROS Docker Simple

A simple template project for [dockerizing](https://www.docker.com/) your [ROS](http://www.ros.org/) code. Have your ROS project set up and running in 3 minutes by putting your catkin workspace in `ws_testserver` and running:

```
sudo apt-get install docker
/script/build
/script/run
```

And that's it!

# myRide App test server
_myride_test_server package_

```
/script/server #runs the  test server with a roscore backend
```
From [ ROS server details](ws_testserver/src/myride_test_server/README.md) 

 

## ROS Nodes

### dummy_node
Publishes all dummy data messages to the relevant topics and subscriebs to would-be interpreted commands. This is exposed by rosbridge_websocket.
#### Publishers:
 * /oscc/speed [std_msgs/Float32]
 * /oscc/steering [std_msgs/Int16]
 * /rosout [rosgraph_msgs/Log]

#### Subscribers: 
 * /command [std_msgs /String]


### video_stream_opencv
The [video_stream_opencv](http://wiki.ros.org/video_stream_opencv) package contains a node to publish a video stream (the protocols that opencv supports are supported, including rtsp, webcams on /dev/video and video files) in ROS image topics, it supports camera info and basic image flipping (horizontal, vertical or both) capabilities, also adjusting publishing rate
.
node name: /zed/zed_stream
The image topics published (along with camera info and parameters) include but not limited to
 * /zed/image_raw
 * /zed/image_raw/compressed
 * /zed/image_raw/compressedDepth



## Server Nodes
### video_web_server
Creates video streams of all available  ROS image transport topics that can be accessed via HTTP.
More on [video_web_server ROS Wiki page](http://wiki.ros.org/web_video_server)
#### URLS:
* Overview of available ROS topics: http://localhost:8080/ 
* Webpage showing a video stream: http://localhost:8080/stream_viewer?* topic={ROS_TOPIC} 
* Video stream URL: http://localhost:8080/stream?topic={ROS_TOPIC} 
* Snapshot of next image: http://localhost:8080/snapshot?topic={ROS_TOPIC}

### rosbridge_websocket
Launches a WebSocket connection server to send and receiva calls over HTTP.
[server launch tutorial](http://wiki.ros.org/rosbridge_suite/Tutorials/RunningRosbridge)
[Roslibjs](http://wiki.ros.org/roslibjs) is a JavaScript library that handles the communication for you

These are for server monitorin purposes, not needed by the App
 * /client_count [std_msgs/Int32]
 * /connected_clients [rosbridge_msgs/ConnectedClients]


# FAQ

### How can I use a different version of ROS?

This works with [any supported version of ROS](https://hub.docker.com/_/ros/), just edit the top line of the Dockerfile. For example, if you want ROS Kinetic:

```
FROM ros:kinetic-ros-base
```

### Can I use [my favourite IDE/editor] with this?

Yup! The `ws_testserver` directory is mounted as a volume inside the container, so you can edit your code as usual, and it will be automatically synced with the container.

### Where is my `ws_testserver` workspace mounted inside the container?

Inside the container, the `ws_testserver` folder will be mounted at root (`/ws_testserver`). 

### How do I install additional packages / dependencies / tools?

Add your dependencies to the RUN command in the `Dockerfile` (this example installs `tmux` and `ros-kinetic-serial` packages using apt, you can add any additional commands or packages you like).

### I need another terminal window in the container!

I recommend [tmux](https://robots.thoughtbot.com/a-tmux-crash-course) as an easy way to manage multiple shells in ROS.

However, if you really want multiple terminal windows instead, you can open a new terminal window on your host computer and run:

```
docker exec -it ros-docker-simple /bin/bash
```

### I want to run a different command on container startup!

You can give your command as an argument to `script/run`, for example:

```
script/run roslaunch example.launch
```

### How do I pass a device (e.g. serial, joystick) to the container?

Edit `script/run` and add the line `--device=/dev/ttyUSB0 \` (changing the `/dev` path to match the path to your device).

### How can I easily coordinate multiple containers and have them talk to one another?

The `docker-compose` tool is the standard way to run multiple containers together: https://docs.docker.com/compose/overview/

### Running the scripts gives me a `permission denied` error!

Is it this one?

```
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.26/containers/create: dial unix /var/run/docker.sock: connect: permission denied.
```

Reason: your user does not have privileges to run Docker. Put your user into the `docker` group or run with `sudo`.

### It gives me a `/ros_entrypoint.sh: line 6: (...): No such file or directory` error!

Instead of giving it a command like this:

```
script/run "cd /tmp/ && ls"
```

Try this:

```
script/run sh -c "cd /tmp/ && ls"
```
