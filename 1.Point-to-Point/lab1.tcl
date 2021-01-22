set ns [ new Simulator]
set tf [ open lab1.tr w] 
$ns trace-all $tf
set nf [ open lab1.nam w] 
$ns namtrace-all $nf

# Create nodes. 

set n0 [$ns node]
set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node]

# Select Color for the flows

$ns color 1 "red" 
$ns color 2 "blue"

$n0 label "Source/udp0" 
$n1 label "Source/udp1" 
$n2 label "Router"

$n3 label "Destination/Null"
# Provide the links and vary bandwidths to see the number of packets dropped. 

$ns duplex-link $n0 $n2 10Mb 300ms DropTail
$ns duplex-link $n1 $n2 10Mb 300ms DropTail 
$ns duplex-link $n2 $n3 1Mb 300ms DropTail

# Set queue sizes between the nodes

$ns set queue-limit $n0 $n2 10
$ns set queue-limit $n1 $n2 10
$ns set queue-limit $n2 $n3 5


# Attach an UDP agent to nodes n0 and n1 and null agent to node n3. 

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

set null3 [new Agent/Null] 
$ns attach-agent $n3 $null3


set udp1 [new Agent/UDP] 
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR] 
$cbr1 attach-agent $udp1


# Set red color to udp0 packets and blue color udp1 packets

$udp0 set class_ 1
$udp1 set class_ 2

#Connect the agents.

$ns connect $udp0 $null3
$ns connect $udp1 $null3


#Set packet size to 500 Mb

$cbr1 set packetSize_ 500Mb

#Set the interval for packets. If the data rate is high then rate of packets drop is high.

$cbr1 set interval_ 0.005

proc finish { } {

global ns nf tf 
$ns flush-trace
exec nam lab1.nam & 
close $tf
close $nf 
exit 0

}

$ns at 0.1 "$cbr0 start" 
$ns at 0.1 "$cbr1 start" 
$ns at 5.0 "finish" 
$ns run