#! /bin/sh

ifconfig eth1 up
ifconfig eth2 up
ifconfig eth3 up
ifconfig eth4 up
sleep 3

ifconfig eth1 down
ifconfig eth2 down
ifconfig eth3 down
ifconfig eth4 down
sleep3

ifconfig eth1 up 192.168.2.161
ifconfig eth2 up 192.168.2.162
ifconfig eth3 up 192.168.2.163
ifconfig eth4 up 192.168.2.164

ping -I eth1 192.168.2.1 &
ping -I eth2 192.168.2.1 &
ping -I eth3 192.168.2.1 &
ping -I eth4 192.168.2.1 &

