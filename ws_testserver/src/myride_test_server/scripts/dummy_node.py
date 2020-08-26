#!/usr/bin/env python
# license removed for brevity
import rospy
from std_msgs.msg import String
from std_msgs.msg import Float32
from std_msgs.msg import Int16


def command_callback(data):
    rospy.loginfo(rospy.get_caller_id() + "recevied %s", data.data)

def node():
    speed_pub = rospy.Publisher('oscc/speed', Float32, queue_size=10)
    steer_pub = rospy.Publisher('oscc/steering', Int16, queue_size=10)
    rospy.Subscriber("command", String, command_callback)

    rospy.init_node('dummy_node', anonymous=True)
    rospy.loginfo("node started")
    rate = rospy.Rate(10) # 10hz


    spd=0.0
    while not rospy.is_shutdown():
      
        spd=(spd+0.1 if spd<100 else 0.0)
        steer=(35+spd//10 if spd<50 else -20-spd//10)

        speed_pub.publish(Float32(spd))
        steer_pub.publish(Int16(steer))

        rate.sleep()

if __name__ == '__main__':
    try:
        node()
    except rospy.ROSInterruptException:
        pass