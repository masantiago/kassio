# kassio

## Requirements
* Install [Raspbian Buster Lite](https://www.raspberrypi.org/downloads/raspbian/) according to  instructions of [Allexis' blog](https://blog.alexellis.io/test-drive-k3s-on-raspberry-pi/) 
* Expand the file system to make use of the entire capacity of the micro SD Card
```console
$ sudo raspi-config
```
* Ntp config
```console
$ sudo apt-get update && sudo apt-get install -y ntp ntpdate
```
Advanced Options -> Expand Filesystem
* Install k3s using [k3sup](https://github.com/alexellis/k3sup)
* Install tiller using [tiller-multiarch](https://github.com/jessestuart/tiller-multiarch)

## Installation
```console
$ helm dependency update
$ helm install --name mas-iot --namespace mas-iot .
```

## Usage
* Add as many user as MQTT devices in the file config/mosquitto-users by hashing afterwards in the mosquitto POD:
```console
$ mosquitto_passwd -U mosquitto-users
```

k3sup install --ip $IP --user $USER --merge --local-path $HOME/.kube/config \
  --context vallecas-iot \
  --k3s-version v1.19.9+k3s1 \
  --k3s-extra-args '--node-ip 192.168.1.201 --node-external-ip 10.8.0.1 --advertise-address 192.168.1.201'

k3sup join --ip $AGENT_IP --server-ip $SERVER_IP --user $USER --k3s-version v1.19.9+k3s1 --k3s-extra-args '--node-ip 192.168.1.202 --node-external-ip 10.8.0.8'