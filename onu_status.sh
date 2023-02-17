#!/bin/bash

# Define as variáveis
ip="$1"
community="$2"
port="$3"
device="$4"
slot="$5"
porta="$6"
oid=".1.3.6.1.4.1.6771.10.1.5.1.5.$device.$slot.$porta"

# Verifica se os parâmetros foram informados corretamente
if [ -z "$ip" ] || [ -z "$community" ] || [ -z "$port" ] || [ -z "$device" ] || [ -z "$slot" ] || [ -z "$porta" ]; then
  echo "Erro: informe todos os parâmetros corretamente. Exemplo: ./onu_status.sh 192.168.3.2 parks 161 1 1 1"
  exit 1
fi

# Executa o snmpget para obter o status da ONU
status=$(snmpget -v2c -c "$community" "$ip:$port" "$oid" | awk '{print $4}')

# Verifica o valor retornado pelo snmpget e exibe o status da ONU
if [ "$status" = "3" ]; then
  echo "ONU ativa"
  exit 0
elif [ "$status" = "1" ]; then
  echo "ONU inativa"
  exit 1
else
  echo "Erro: status desconhecido"
  exit 1
fi
