#!/bin/sh
#tcpdump.sh
run=1
interface=${input:-$interface}
host1=${input:-$host1}
host2=${input:-$host2}
protocol=${input:-$protocol}
personalcommand=${input:-$personalcommand}
pcapfile='-w /tmp/tcpdump.pcap'


function badinput(){
	printf "\n Unrecognized option, aborting \n"
 	exit 0
}

tcpdump='tcpdump -nli'
function tcpdumpinterface(){ 
	 $tcpdump $interface 
}

clear
while [ $run -eq 1 ]; do

        printf "== tcpdump == \n"
	printf "Please run this script as root! \n" 
	printf "If using PCAP file option, the file is saved in /tmp/tcpdump.pcap \n" 
	printf "[ 1 ] tcpdump info: Network interfaces available for the capture  \n"
	printf "[ 2 ] tcpdump: Capture the traffic of a interface? \n"
	printf "[ 3 ] tcpdump: Capture the traffic of a interface with a host? \n"
	printf "[ 4 ] tcpdump: Capture the traffic of a interface with two host? \n"
        printf "[ 5 ] tcpdump: Capture the traffic of a interface with a host and a protocol? \n"
        printf "[ 6 ] tcpdump: Capture the traffic of a interface with two host and a protocol? \n"
        printf "[ 7 ] tcpdump: Make here your own shit! \n"
        printf "[ 8 ] tcpdump: exit! \n"


	printf ">"
  	read source_choice

	if [ $source_choice -eq 1 ]; then
             	tcpdump -D | less

        elif [ $source_choice -eq 2 ]; then
                printf "what interface do you want to listen? \n"
                read -p "Enter: " interface
		read -p "Do you need to save the capture to a pcap file?" yn
		case $yn in
                [Yy]* ) tcpdumpinterface $pcapfile;; 
		[Nn]* ) tcpdumpinterface;;
		* ) echo "Please answer yes or no.";;
                esac
	
        elif [ $source_choice -eq 3 ]; then
                printf "what interface do you want to listen? \n"
                read -p "Enter: " interface
		printf "what host do you want to listen? \n"
                read -p "Enter: " host1
                read -p "Do you need to save the capture to a pcap file?" yn
                case $yn in
                [Yy]* ) tcpdumpinterface host $host1 $pcapfile;;
                [Nn]* ) tcpdumpinterface host $host1;;
                * ) echo "Please answer yes or no.";;
                esac

	elif [ $source_choice -eq 4 ]; then
                printf "what interface do you want to listen? \n"
                read -p "Enter: " interface
                printf "what host do you want to listen? \n"
                read -p "Enter: " host1
		printf "what host do you want to listen? \n"
                read -p "Enter: " host2
                read -p "Do you need to save the capture to a pcap file?" yn
                case $yn in
                [Yy]* ) tcpdumpinterface host $host1 and $host2 $pcapfile;;
                [Nn]* ) tcpdumpinterface host $host1 and $host2;;
                * ) echo "Please answer yes or no.";;
                esac
 
   	elif [ $source_choice -eq 5 ]; then
                printf "what interface do you want to listen? \n"
                read -p "Enter: " interface
                printf "what host do you want to listen? \n"
                read -p "Enter: " host1
                printf "what protocol do you want to listen? \n"
                read -p "Enter: " protocol
                read -p "Do you need to save the capture to a pcap file?" yn
                case $yn in
                [Yy]* ) tcpdumpinterface host $host1 and $protocol $pcapfile;;
                [Nn]* ) tcpdumpinterface host $host1 and $protocol;;
                * ) echo "Please answer yes or no.";;
                esac

        elif [ $source_choice -eq 6 ]; then
                printf "what interface do you want to listen? \n"
                read -p "Enter: " interface
                printf "what host do you want to listen? \n"
                read -p "Enter: " host1
		printf "what host do you want to listen? \n"
                read -p "Enter: " host2
                printf "what protocol do you want to listen? \n"
                read -p "Enter: " protocol
                read -p "Do you need to save the capture to a pcap file?" yn
                case $yn in
                [Yy]* ) tcpdumpinterface host $host1 and $host2 and $protocol $pcapfile;;
                [Nn]* ) tcpdumpinterface host $host1 and $host2 and $protocol;;
                * ) echo "Please answer yes or no.";;
                esac

	elif [ $source_choice -eq 7 ]; then
                printf "Put your personal command here: \n"
		printf "tcpdump -nli is the basic of the command! \n"
                printf "== option you can add == \n" 
                printf "ex: eth0 host ip and icmp and port number -w /tmp/name.pcap -C 3 -W 3 \n"        
                read -p "Enter: " personalcommand
		tcpdumpinterface $personalcommand


	elif [ $source_choice -eq 8 ]; then
               exit 0

        else
	       badinput

	fi
   
done
