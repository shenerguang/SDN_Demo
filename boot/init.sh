#!/bin/ash

echo "Networking Initial, Please wait ..."
# Due to driver issue, networking interfaces should be set up, then down at first.
ifconfig eth1 up
ifconfig eth2 up
ifconfig eth3 up
ifconfig eth4 up
sleep 3

ifconfig eth0 down
ifconfig eth1 down
ifconfig eth2 down
ifconfig eth3 down
ifconfig eth4 down

ifconfig eth0 hw ether 00:0a:35:00:14:00
ifconfig eth1 hw ether 00:0a:35:01:14:01
ifconfig eth2 hw ether 00:0a:35:01:14:02
ifconfig eth3 hw ether 00:0a:35:01:14:03
ifconfig eth4 hw ether 00:0a:35:01:14:04

sleep 3

ifconfig eth0 10.0.0.14/24

ifconfig eth1 up
ifconfig eth2 up
ifconfig eth3 up
ifconfig eth4 up
ifconfig lo up

sleep 3
echo "@++< Initial Done"

route add default gw 10.0.0.1
#cd /root
#./ofup

cd /root/ofsoftswitch13hwt
./udatapath/ofdatapath --datapath-id=000000000014 --interfaces=eth1,eth2,eth3,eth4 ptcp:6632 --no-slicing &
sleep 5
./secchan/ofprotocol  tcp:127.0.0.1:6632 tcp:10.0.0.1:6633 --inactivity-probe=90 &
sleep 5
ifconfig eth0 up



