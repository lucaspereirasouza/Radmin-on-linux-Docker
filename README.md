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

# Pre-install
## Docker installation:
https://docs.docker.com/engine/install/

## Virt-manager
### apt install virt-manager
## Dockur image document
<a href="https://github.com/dockur/windows"><img height=50px src="https://github.com/dockur/windows/raw/master/.github/logo.png"></img></a><br>
[dockurr/windows](https://github.com/dockur/windows)

Configuration used:
```
RAM_SIZE: "4G"
CPU_CORES: "1"
DISK_SIZE: "12G"
``` 
## Network:
### Internal network:
```
subnet: 26.0.0.0
gateway: 26.0.0.1
ipv4: 26.0.0.3
```
### External network:
```
subnet: 27.0.0.0
gateway: 27.0.0.1
ipv4: 27.0.0.3
```

## Windows versions aliases, also link redirectable:
### ``"win11","win10","ltsc10","win81","win7","vista","winxp"`` <br>

## Tested versions:

| Windows 7 SP1 | Windows Tiny10 Core  | Windows Tiny11 Core Beta 1 | TinyCore 1809 Beta4 x64  | 
| :------------ |:---------------:| -----:|-----:|
| 3.0 GB | 3.6 GB | 2GB | 936.7MB|
| Working | Not tested | Not tested | Not working |

## Installation
```
git clone https://github.com/lucaspereirasouza/RadminVPNOnLinuxAlternative.git
cd RadminVPNOnLinuxAlternative/
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
### port: 8006
### Web-viewer RDP:
### http://localhost:8006/

## virt-manager for networking configuration
...

QEMU
Virt-Manager

## Disclaimer
The product names, logos, brands, and other trademarks referred to within this project are the property of their respective trademark holders. This project is not affiliated, sponsored, or endorsed by Microsoft Corporation.
