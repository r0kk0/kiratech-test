global
    daemon
    log 127.0.0.1 local0 debug
    maxconn 50000
    nbproc 1

defaults
    mode tcp
    timeout connect 5s
    timeout client 25s
    timeout server 25s
    timeout queue 10s

frontend kubernetes-frontend
%{~for k,v in vms}
%{~if v.is_master == false && v.is_proxy == true}
bind ${v.system_ipv4_address}:6443
%{~endif}
%{~endfor}
    mode tcp
    option tcplog
    default_backend kubernetes-backend

backend kubernetes-backend
    mode tcp
    option tcp-check
    balance roundrobin
%{~for k,v in vms}
%{~if v.is_master == true && v.is_proxy == false}
server ${v.vm_name} ${v.system_ipv4_address}:6443 check fall 3 rise 2
%{~endif}
%{~endfor}
