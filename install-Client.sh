 #!/bin/bash
echo "-----------------------------------------------------------"
echo "The computer will restart after completing the installation"
echo "-----------------------------------------------------------"
sleep 3s
apt update
apt -y install task-xfce-desktop
apt -y install xfce4-goodies
  

echo "source /etc/network/interfaces.d/*" >> new_interfaces
echo "# The loopback network interface" >> new_interfaces
echo "auto lo" >> new_interfaces
echo "iface lo inet loopback" >> new_interfaces
echo "" >> new_interfaces

echo "Enter name interface:"
read interface
echo "Enter default gateway:"
read gateway
echo "Enter static ip for the webserver:"
read ip
echo "Enter netmask:"
read netmask

echo "allow-hotplug $interface" >> new_interfaces
echo "auto $interface" >> new_interfaces
echo "iface $interface inet static" >> new_interfaces
echo "	address $ip" >> new_interfaces
echo "	netmask $netmask" >> new_interfaces
echo "	gateway $gateway" >> new_interfaces

cp new_interfaces /etc/network/interfaces
rm new_interfaces
ifdown "$interface"
ifup "$interface"

echo "Installation complete - Press enter to reboot"
read enter
reboot
