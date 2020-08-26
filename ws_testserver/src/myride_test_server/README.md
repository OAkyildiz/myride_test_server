
# myride_test_server

## ROS Nodes

### dummy_node
Publishes all dummy data messages to the relevant topics and subscribes to would-be interpreted commands. This is exposed by rosbridge_websocket.

The App will be publishing to command and subcscire to the speed and steering data
#### Publishers:
 * /oscc/speed [std_msgs/Float32](docs.ros.org/melodic/api/std_msgs/html/msg/Float32.html)
 * /oscc/steering [std_msgs/Int16](docs.ros.org/melodic/api/std_msgs/html/msg/Int16.html)

 * /rosout [rosgraph_msgs/Log] - just ROS logging

#### Subscribers: 
 * /command [std_msgs/String](docs.ros.org/melodic/api/std_msgs/html/msg/String.html)


### video_stream_opencv
The [video_stream_opencv](http://wiki.ros.org/video_stream_opencv) package contains a node to publish a video stream (the protocols that opencv supports are supported, including rtsp, webcams on /dev/video and video files) in ROS image topics, it supports camera info and basic image flipping (horizontal, vertical or both) capabilities, also adjusting publishing rate
.
node name: /zed/zed_stream
The image topics published (along with camera info and parameters) include but not limited to
 * /zed/image_raw
 * /zed/image_raw/compressed
 * /zed/image_raw/compressedDepth
 
 The app is most likely to use ` /zed/image_raw` or `/zed/image_raw/compressed`

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

