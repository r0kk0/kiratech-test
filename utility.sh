#!/bin/bash

case "$1" in
        init)
            terraform init
            ;;

        plan)
            terraform plan -out cluster.out -var-file secrets.tfvars
            ;;

        apply)
            terraform apply "cluster.out"
            ;;

        destroy)
            terraform destroy -var-file secrets.tfvars
            ;;
        *)
            echo $"Usage: $0 {init|plan|apply|destroy}"
            exit 1
esac
