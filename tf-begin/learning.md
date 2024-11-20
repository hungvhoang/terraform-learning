## AWS Elastic Load Balancer
- ELB provides 3 types of load balancer:
+ Application load balancer (ALB): Appear in layer 7 (application), handle http/https traffic.
+ Network load balancer (NLB): Appear in layer 4 (transport), handle tcp/udp/tls traffic.
+ Classic load balancer (CLB): Appear in both layer 4 and 7, handle traffic same as those 2 types but less features.

- Due to this learning, suggest using ALB

## ALB
- Listener: a process that check for connection requests, listen on specific ports and protocol(ex: port 80, http)
+ Listener rules: take requests and send to the specific path/hostname
- Target groups: 1-n servers that receive requests from the load balancer