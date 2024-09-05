<br/>
<div align="center">
</a>
<h3 align="center">Radmin VPN no linux com Dockurr</h3>
<p align="center">
Usando Radmin vpn com Windows virtualizado no Qemu!
<br/>
<br/>
</p>
</div>

# Pré instalação
## docker
https://docs.docker.com/engine/install

## Documentação do container do windows
<a href="https://github.com/dockur/windows"><img height=50px src="https://github.com/dockur/windows/raw/master/.github/logo.png"></img></a><br>
[dockurr/windows](https://github.com/dockur/windows)


Requisitos recomendados para a utilização do container <br>
```
RAM_SIZE: "4G"
CPU_CORES: "1"
DISK_SIZE: "12G"
```
## Será criado duas redes, interna para a conexão do Radmin, e a externa para a conexão de ponte com a rede interna e o Linux.
### rede interna:
```
subnet: 26.0.0.0
gateway: 26.0.0.1
ipv4: 26.0.0.3
```
## Aliases para os tipos de windows disponiveis
### ``"win11","win10","ltsc10","win81","win7","vista","winxp"`` <br>

## Versões testadas com menor peso de armazenamento e proximo de compatibilidade
| Windows 7 SP1 | Windows Tiny10 Core  | Windows Tiny11 Core Beta 1 | TinyCore 1809 Beta4 x64  | 
| :------------ |:---------------:| -----:|-----:|
| 3.0 GB | 3.6 GB | 2GB | 936.7M|
| Funcional | Não testado | Não testado | Não funcional |

```
wget https://raw.githubusercontent.com/lucaspereirasouza/RadminVPNOnLinuxAlternative/main/docker-compose.yaml
docker compose up
```
## ou crie o docker-compose.yaml

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
    networks:
      _host:
        ipv4_address: 172.11.0.2
      _external:
        ipv4_address: 172.12.0.3
networks:
  _host:
    name: radminvpn_internal
    internal: true
    ipam:
      driver: default
      config:
      - subnet: 172.11.0.0/16
        gateway: 172.11.0.1
  _external:
    name: radminvpn_external
    external: false
    ipam:
      driver: default
      config:
      - subnet: 172.12.0.0/16
        gateway: 172.12.0.1
```
Dentro do diretório, execute o comando ``` docker compose up ``` e acesse o localhost para ter o acesso remoto do seu windows
http://localhost:8006/


[Em desenvolvimento]
Docker network
virsh net-*
QEMU

## Disclaimer
The product names, logos, brands, and other trademarks referred to within this project are the property of their respective trademark holders. This project is not affiliated, sponsored, or endorsed by Microsoft Corporation.
