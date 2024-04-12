# RadminVPNOnLinuxAlternative
## Esse repositorio serve de manual para a utilização do radmin vpn em um container em um linux.

# instalação do docker

Debian:
https://docs.docker.com/engine/install/debian/

Ubuntu:
https://docs.docker.com/engine/install/ubuntu/

Fedora
https://docs.docker.com/engine/install/fedora/
<br>
## Image pull:<br>
<a href="https://github.com/dockur/windows"><img height=50px src="https://github.com/dockur/windows/raw/master/.github/logo.png"></img></a><br>
[dockurr/windows](https://github.com/dockur/windows)



Requisitos necessarios para a utilização do windows no container <br>
```
RAM_SIZE: "4G"
CPU_CORES: "1"
DISK_SIZE: "12G"
```



## adquira o arquivo direto do github

```
wget https://raw.githubusercontent.com/lucaspereirasouza/RadminVPNOnLinuxAlternative/main/docker-compose.yaml
docker compose up
```

## ou crie o docker-compose.yaml e insira as configurações

| Windows 7 SP1 | Windows Tiny10 Core  | Windows Tiny11 Core Beta 1 | TinyCore 1809 Beta4 x64  | 
| :------------ |:---------------:| -----:|-----:|
| 3.0 GB | 3.6 GB | 2GB | 936.7M|
| Funcional | Não testado | Não testado | Não funcional |


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
