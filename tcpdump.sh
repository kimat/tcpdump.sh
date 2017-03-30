#!/bin/sh
#tcpdump.sh
run=1
interface=${input:-$interface}
host1=${input:-$host1}
host2=${input:-$host2}
protocol=${input:-$protocol}
personalcommand=${input:-$personalcommand}

function badinput(){
	printf "\n Unrecognized option, aborting \n"
 	exit 0
	
}



clear
while [ $run -eq 1 ]; do

        printf "== tcpdump == \n"
	printf "Please tun this script as root! \n" 
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
		read -p "Do you need to save the capture to a pcap file?" yn_1
		case $yn_1 in
                [Yy]* ) tcpdump -nli $interface -w /tmp/tcpdump.pcap;; 
		[Nn]* ) tcpdump -nli $interface;;
		* ) echo "Please answer yes or no.";;
                esac
	
        elif [ $source_choice -eq 3 ]; then
                printf "what interface do you want to listen? \n"
                read -p "Enter: " interface
		printf "what host do you want to listen? \n"
                read -p "Enter: " host1
                read -p "Do you need to save the capture to a pcap file?" yn_1
                case $yn_1 in
                [Yy]* ) tcpdump -nli $interface host $host1 -w /tmp/tcpdump.pcap;;
                [Nn]* ) tcpdump -nli $interface host $host1;;
                * ) echo "Please answer yes or no.";;
                esac

	elif [ $source_choice -eq 4 ]; then
                printf "what interface do you want to listen? \n"
                read -p "Enter: " interface
                printf "what host do you want to listen? \n"
                read -p "Enter: " host1
		printf "what host do you want to listen? \n"
                read -p "Enter: " host2
                read -p "Do you need to save the capture to a pcap file?" yn_1
                case $yn_1 in
                [Yy]* ) tcpdump -nli $interface host $host1 and $host2 -w /tmp/tcpdump.pcap;;
                [Nn]* ) tcpdump -nli $interface host $host1 and $host2;;
                * ) echo "Please answer yes or no.";;
                esac
 
   	elif [ $source_choice -eq 5 ]; then
                printf "what interface do you want to listen? \n"
                read -p "Enter: " interface
                printf "what host do you want to listen? \n"
                read -p "Enter: " host1
                printf "what protocol do you want to listen? \n"
                read -p "Enter: " protocol
                read -p "Do you need to save the capture to a pcap file?" yn_1
                case $yn_1 in
                [Yy]* ) tcpdump -nli $interface host $host1 and $protocol -w /tmp/tcpdump.pcap;;
                [Nn]* ) tcpdump -nli $interface host $host1 and $protocol;;
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
                read -p "Do you need to save the capture to a pcap file?" yn_1
                case $yn_1 in
                [Yy]* ) tcpdump -nli $interface host $host1 and $host2 and $protocol -w /tmp/tcpdump.pcap;;
                [Nn]* ) tcpdump -nli $interface host $host1 and $host2 and $protocol;;
                * ) echo "Please answer yes or no.";;
                esac

	elif [ $source_choice -eq 7 ]; then
                printf "Put your personal command here: \n"
		printf "tcpdump -nli is the basic of the command! \n"
                printf "== option you can add == \n" 
                printf "ex: eth0 host ip and icmp and port number -w /tmp/name.pcap -C 3 -W 3 \n"        
                read -p "Enter: " personalcommand
		tcpdump -nli $personalcommand


	elif [ $source_choice -eq 8 ]; then
               exit 0

       else
	       badinput

	fi
   
done

