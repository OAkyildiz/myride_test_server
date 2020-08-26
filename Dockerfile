ARG DISTRO=melodic

FROM ros:$DISTRO-ros-base
ENV OVERLAY_WS=/ws_testserver
ENV DISTRO=melodic
RUN sudo apt-get install apt -y
RUN apt update && apt install -y \
    tmux python-pip apt-utils\
    python-catkin-tools \
    ros-$DISTRO-serial \
    ros-$DISTRO-rosbridge-suite \
    ros-$DISTRO-web-video-server \
    ros-$DISTRO-video-stream-opencv \
    && echo "source /ws_testserver/devel/setup.bash" >> /root/.bashrc \
    && python -m pip install defusedxml && python -m pip install netifaces


ADD ws_testserver /$OVERLAY_WS
WORKDIR $OVERLAY_WS

RUN . /opt/ros/$DISTRO/setup.sh && catkin build

RUN sed --in-place --expression \
      '$isource "$OVERLAY_WS/devel/setup.bash"' \
      /ros_entrypoint.sh


EXPOSE 11311
EXPOSE 8000
EXPOSE 8080

