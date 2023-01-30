
## Virtual Network
A range of IP address meets RFC 1918

## Subnet
Part of Virtual Network.

- 5 IPs are taken (always taken) (/29 is smallest cidr)
  - .0 = network address
  - .1 = gateway
  - .2 .3 = dns
  - .255 = broadcast
- subnet span availability zones
- Actually the NIC of vm cnnected to network, not vm

## VM NIC
- IP comes via Fabric
- Can reserve in ARM
- vm can have multiple nics
  - need to connect same virtual network.
  - can connect to different subnets
  - not that necessary in software-defined-networking; better nsg
- support accelerate networking - bypass hypervisor switch. connects to virtual function on nic.
- multiple ip on nic - private IP (required). public ip (optional)

## supported type of ip traffic - L3
- standard IP based (tcp udp icmp) L4
- Blocked: multicast, broadcast, generic routing encapsulation (GRE)
- can't ping or tracert azure gateway
- traditional L2 for vlan - not supported
- azure has network watcher

## ipv6
- can dual stack ipv4 and ipv6
- ipv4 - 32bit; ipv6 - 128bit
- fd - non-routable
- always dual stack. can't be IPv6 only.

## external access
- no dmz
- by default azure provide snat/pat
- by default can access internet. only reponse
- implicit method - by default
- explicit method 
  - instance level public IP 
    - almost never the solution
    - connect direct to resource
    - less options for security
  - app gateway - regional
  - std load balencer
  - nat gateway
- don't enable rdp or ssh. use defender JIT or bastion (managed jump box)

## connecting virtual networks
- past: connect vnet via site-to-site (S2S) VPN or ExpressRoute - each have problems
  - S2S - IPSEC - slow throughput
  - ExpressRoute - Meet box in different site - Latency issue
- vnet peering - connect to each other via backbone.