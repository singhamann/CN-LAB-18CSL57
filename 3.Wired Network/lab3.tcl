set ns [ new Simulator]
set tf [ open lab3.tr w] 
$ns trace-all $tf
set nf [ open lab3.nam w] 
$ns namtrace-all $nf

# Create nodes. 

set n0 [$ns node]
set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node]

$ns make-lan "$n0 $n1 $n2 $n3" 10Mb 10ms LL Queue/DropTail Mac/802_3

$ns color 1 "red" 
$ns color 2 "blue"

# Attach an UDP agent to nodes n0 and n1 and null agent to node n3. 

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set sink3 [new Agent/TCPSink] 
$ns attach-agent $n3 $sink3


set tcp2 [new Agent/TCP] 
$ns attach-agent $n2 $tcp2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set sink1 [new Agent/TCPSink] 
$ns attach-agent $n1 $sink1


#Connect the agents.

$ns connect $tcp0 $sink3
$ns connect $tcp2 $sink1

set file2 [open file2.tr w]
$tcp2 attach $file2
$tcp2 trace cwnd_


$tcp0 set class_ 1
$tcp2 set class_ 2

set file0 [open file0.tr w]
$tcp0 attach $file0
$tcp0 trace cwnd_
$tcp0 set maxcwnd_ 10


proc finish { } {

global ns nf tf 
$ns flush-trace
exec nam lab3.nam & 
close $tf
close $nf 
exit 0

}

$ns at 0.1 "$ftp0 start" 
$ns at 1.5 "$ftp0 stop" 

$ns at 2 "$ftp0 start" 
$ns at 3 "$ftp0 stop" 

$ns at 0.2 "$ftp2 start" 
$ns at 2 "$ftp2 stop" 

$ns at 2.5 "$ftp2 start" 
$ns at 4 "$ftp2 stop" 
 
$ns at 5.0 "finish"
$ns run



