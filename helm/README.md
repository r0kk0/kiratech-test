Deploy storage driver
helm install csi-driver-nfs csi-driver-nfs/csi-driver-nfs --namespace kube-system --version v4.1.0

helm pull bitnami/wordpress

tar xvfz wordpress-blabla.tgz

Modifica file values

helm install wordpress ./wordpress --namespace wordpress --create-namespace -f wordpress/values.yaml
