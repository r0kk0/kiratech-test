# kiratech-test

Le macchine virtuali verranno provisionate su un cluster ESXi VMware (homeLab)



Rinominare il file secrets.tfvars.example in secret.tfvars e lanciare i comandi terraform riferendo il file (ex. terraform destroy -var-file secret.tfvars) 

Per praticità d'uso, verrà utilizzata l'img di ubuntu 22.04 LTS reperibile qui: https://cloud-images.ubuntu.com/releases/server/22.04/release/ubuntu-22.04-server-cloudimg-amd64.ova 
Dovrà essere importata e convertita in template su VCenter.
L'accesso root è disabilitato e il login ssh è possibile solo tramite key.
La configurazione di base dell'OS viene eseguita tramite cloud-init passato come parametro vApp con terraform.

Per il deploy del cluster k8s è vivamente consigliato l'utilizzo di un venv python. Terraform lancerà in automatico il playbook.


Verrà lanciato anche un benchmark di security (kube-bench). 

Nota: per eseguire il benchmark e altre operazioni su k8s è necessario avere kubectl nella $PATH di sistema.

La scelta deriva dal fatto che vengono eseguiti i benchmark del CIS (https://www.cisecurity.org/benchmark/kubernetes), già conosciuto perchè utilizzato su sistemi operativi server nella farm.

Nel cluster verrà provisionata una StorageClass di tipo NFS che si appoggia a un nas esterno.

L'applicazione scelta per il deploy con Helm è Wordpress, con mariadb e memcached abilitati.
