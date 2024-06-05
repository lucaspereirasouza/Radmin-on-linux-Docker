<br/>
<div align="center">
</a>
<h3 align="center">Alternativa de Radmin VPN no linux</h3>
<p align="center">
Radmin VPN using windows docker container virtualization
<br/>
<br/>
</p>
</div>

# instalação do docker

Debian:
https://docs.docker.com/engine/install/debian/

Ubuntu:
https://docs.docker.com/engine/install/ubuntu/

Fedora
https://docs.docker.com/engine/install/fedora/

Windows
https://docs.docker.com/desktop/install/windows-install/

## Documentação do container do windows
<a href="https://github.com/dockur/windows"><img height=50px src="https://github.com/dockur/windows/raw/master/.github/logo.png"></img></a><br>
[dockurr/windows](https://github.com/dockur/windows)



Requisitos necessarios para a utilização do windows no container <br>
```
RAM_SIZE: "4G"
CPU_CORES: "1"
DISK_SIZE: "12G"
```
## Crie duas redes, uma rede interna e uma rede externa 

### rede interna:
```
subnet: 26.0.0.0
gateway: 26.0.0.1
ipv4: 26.0.0.3
```
## a versão colocada dentro do docker-compose pode ser escolhida de forma predefinida 
### ``"win11","win10","ltsc10","win81","win7","vista","winxp"`` <br>
ou por meio de uma source

## Versões testadas com menor peso de armazenamento e proximo de compatibilidade
| Windows 7 SP1 | Windows Tiny10 Core  | Windows Tiny11 Core Beta 1 | TinyCore 1809 Beta4 x64  | 
| :------------ |:---------------:| -----:|-----:|
| 3.0 GB | 3.6 GB | 2GB | 936.7M|
| Funcional | Não testado | Não testado | Não funcional |


## adquira o arquivo direto do github

```
wget https://raw.githubusercontent.com/lucaspereirasouza/RadminVPNOnLinuxAlternative/main/docker-compose.yaml
docker compose up
```
## ou crie o docker-compose.yaml e insira as configurações

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
Dentro do diretório, execute o comando ``` docker compose up ``` e acesse o localhost para ter o acesso remoto do seu windows
http://localhost:8006/


[Em desenvolvimento]
Docker network

## necessario uma conexão bridge dentro do windows com o radmin vpn e a conexão interna

Criação da rede virtual interna
Execute o comando abaixo em seu pseudoTerminal/bash
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
