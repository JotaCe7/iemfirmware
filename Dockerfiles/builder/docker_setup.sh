#!/bin/bash

# This script has to be run by root!
if [ "$(whoami)" != "root" ]; then
  exit 1;
fi

## Download arduino 
#wget https://www.arduino.cc/download_handler.php?f=/arduino-1.8.12-linux64.tar.xz 
#
## Install arduino
#cwd=$(pwd)
#tar xvf arduino-1.8.12-linux64.tar.xz 
#cd arduino-1.8.12-linux64 
#./install.sh
#cd $cwd

# The arduino-cli image only gets the go environment but doesn't install arduino-cli, to install it:
#cd ~ && curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
#echo 'export PATH=/root/bin:$PATH' >> ~/.bashrc
#source ~/.bashrc
cat <<EOF >>~/arduino-cli.yaml
board_manager:
  additional_urls:
    - http://arduino.esp8266.com/stable/package_esp8266com_index.json
    - https://dl.espressif.com/dl/package_esp32_index.json
EOF
arduino-cli core update-index
arduino-cli core install esp32:esp32
arduino-cli lib install aunit@1.3.0  # install this particular version

###########################################
### This is for setting up the emulator ###
###########################################
cd ~
git clone https://github.com/eds000n/qemu-xtensa-esp32 -b esp-develop 
cd qemu-xtensa-esp32
./configure --target-list=xtensa-softmmu     --enable-debug --enable-sanitizers     --disable-strip     --disable-capstone --disable-vnc
make -j2


cd ~
wget https://github.com/JotaCe7/iemfirmware/blob/master/Dockerfiles/builder/docker_setup.sh
./docker_setup.sh


###########################################
### This is for setting up the building ###
###########################################
# Install the esp32 stuff
#cd ~ && \
#usermod -a -G dialout root && \
wget https://bootstrap.pypa.io/get-pip.py && \
python get-pip.py && \
pip install pyserial
apt-get install nano clang-format clang-tidy

