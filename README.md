<br/>
<div align="center">
</a>
<h3 align="center">Radmin VPN on Docker</h3>
<p align="center">
Radmin on Linux using docker virtualization
<br/>
<br/>
</p>
</div>

# Docker installation:

Debian:
https://docs.docker.com/engine/install/debian/

Ubuntu:
https://docs.docker.com/engine/install/ubuntu/

Fedora
https://docs.docker.com/engine/install/fedora/

Windows
https://docs.docker.com/desktop/install/windows-install/

## Docker image document
<a href="https://github.com/dockur/windows"><img height=50px src="https://github.com/dockur/windows/raw/master/.github/logo.png"></img></a><br>
[dockurr/windows](https://github.com/dockur/windows)



Minimum requisited for use Dockur <br>
```
RAM_SIZE: "4G"
CPU_CORES: "1"
DISK_SIZE: "12G"
``` 

### Internal network:
```
subnet: 26.0.0.0
gateway: 26.0.0.1
ipv4: 26.0.0.3
```
## Windows versions aliases, also you can redirect an iso with a link: 
### ``"win11","win10","ltsc10","win81","win7","vista","winxp"`` <br>

## Tested versions, stability, functionality, etc:
| Windows 7 SP1 | Windows Tiny10 Core  | Windows Tiny11 Core Beta 1 | TinyCore 1809 Beta4 x64  | 
| :------------ |:---------------:| -----:|-----:|
| 3.0 GB | 3.6 GB | 2GB | 936.7M|
| Works | Not tested | Not tested | Not working |


## Installation

## Get this archive directly from github

```
wget https://raw.githubusercontent.com/lucaspereirasouza/RadminVPNOnLinuxAlternative/main/docker-compose.yaml
docker compose up
```
## or create a docker-compose.yaml

```yaml

services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "win7"
      RAM_SIZE: "4G"
      CPU_CORES: "2"
      DISK_SIZE: "12G"
    devices:
      - /dev/kvm
    cap_add:
      - NET_ADMIN
    ports:
      - 8006:8006
      - 3389:3389/tcp
      - 3389:3389/udp
    stop_grace_period: 2m
    restart: on-failure
    volumes:
      - /var/win:/storage
```
then do ``` docker compose up ```
port: 8006
http://localhost:8006/


[Developing]
Docker network
In this moment the virtualizer QEMU doesn't have automation to recognize the networks created outside the emulation
...

```bash
docker network create -d macvlan \
    --subnet={ip}/{mascara} \
    --gateway={gateway}.1 \
    --ip-range=ip-range/28 \
    -o parent=eth0 vlan
```


QEMU

## Disclaimer
The product names, logos, brands, and other trademarks referred to within this project are the property of their respective trademark holders. This project is not affiliated, sponsored, or endorsed by Microsoft Corporation.
