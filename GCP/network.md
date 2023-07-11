

## VPC - virtual private cloud
- project can have up to 15 networks (shared/peered)
- network has no IP range. just construct
- global and span all available region
- kind: default, auto, custom
  - default - every project provided
    - one subnet per region
    - default firewall rules
  - auto
    - default network
    - one subnet per region
    - regional IP
    - fixed /20 subnet per region
    - expandable to /16
  - custom
    - no default subnet
    - full control of subnet and IP ranges
    - regional IP allocation
    - expandable IP ranges
    - one way conversion form auto -> custom
- network isolation
  - networks can span multiple zones.
  - example
    - Network 1: A, B
    - Network 2: C
    - Network 3: D
    - A and B on same network, can access via internal IP
    - C and D on diff network, can access via external IP (not need public internet, google edge servers)
  - VPN can allow access from OnPrem to google private network. 
    - Can access onPrem to different networks
- subnets can cross zones if in same network
- .0 reserve for subnet
- .1 reserve for gateway
- last and 2nd last reserve for broadcast
- .2 first available | assignable
- can expand subnet without any shutdowns
  - new subnet mask can't overlap with any other subnet
  - IP range must be valid cidr block
  - can expand, not shrink
  - rule of thumb, avoid creating large subnets
- VM has have internal and external IP addr
- internal IP is the hostname
  - also FQDN [hostname].[zone].c.[project-id].internal
  - ip addr can change. DNS name is the same
  - each instance has metadata server, acts as DNS server
- external ip.
  - access from public internet
  - public dns is not published automatically
- cloud dns
  - google dns service
  - update dns records on this service.
- routes and firewall
  - cloud routes - product
  - can overwrite default routes
  - routes created when network or subnet created
  - cloud firewall rule protect from unapproved connections
    - rules applied at network, but denied on instance
    - stateful: allow bidirectional communication when connection is established
    - implicit deny all ingree, allow all egress 
    - rules: direction, source/destination, protocol and port, action, priorty, rule assignment (can assign to certain instances)


## VM


## Other
- Project - associate objects with billing