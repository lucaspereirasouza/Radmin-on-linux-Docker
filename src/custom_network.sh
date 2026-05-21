#!/usr/bin/env bash

# Configuração da rede secundária (RadminVPN - eth1)
# O script dockur/windows `network.sh` já tratou de eth0 em NET_OPTS ou ARGS.
# Aqui nós adicionamos a segunda interface.

if [ -d "/sys/class/net/eth1" ]; then
    echo "Configurando rede secundária (eth1) para KVM..."
    
    # Gerar um MAC address único para a segunda interface
    MAC2=$(echo "eth1-$HOSTNAME" | md5sum | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')
    
    # Criar uma interface macvtap1 atrelada à eth1
    ip link add link eth1 name macvtap1 type macvtap mode bridge
    ip link set macvtap1 up
    
    # Obter o ifindex do macvtap1
    TAP_INDEX=$(< /sys/class/net/macvtap1/ifindex)
    
    # O arquivo /dev/tapX pode demorar um pouquinho para aparecer
    sleep 1
    
    if [ -c "/dev/tap${TAP_INDEX}" ]; then
        # Mapear o fd 40 para o device tap
        exec 40<>/dev/tap${TAP_INDEX}
        
        # Adicionar os parâmetros ao QEMU
        ARGS+=" -netdev tap,fd=40,id=hostnet1 -device virtio-net-pci,netdev=hostnet1,id=net1,mac=${MAC2^^}"
        
        echo "Rede secundária configurada com sucesso. MAC: ${MAC2^^}"
    else
        echo "Erro: Dispositivo /dev/tap${TAP_INDEX} não foi criado."
    fi
else
    echo "Interface eth1 não encontrada. Pulando a configuração da rede secundária."
fi
