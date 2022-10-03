[k8s_masters]
%{~for k,v in vms}
%{~if v.is_master == true && v.is_proxy == false}
${v.vm_name}
%{~endif}
%{~endfor}
[k8s_workers]
%{~for k,v in vms}
%{~if v.is_master == false && v.is_proxy == false}
${v.vm_name}
%{~endif}
%{~endfor}
[haproxy]
%{~for k,v in vms}
%{~if v.is_master == false && v.is_proxy == true}
${v.vm_name}
%{~endif}
%{~endfor}

[k8s_all:children]
k8s_masters
k8s_workers

[k8s_all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[haproxy:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
