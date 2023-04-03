Landing Zone WebFG

Autenticación usuario en consola:
gcloud auth login
gcloud auth application-default login

Pasos seguidos:

1. Creación proyecto CICD mediante script: Incluye SA con permisos para desplegar y bucket donde se guarda el state.
2. Creación de folders de la organización:
    - g-fldr-cs
        - g-fldr-cs-net
        - g-fldr-cs-devops
3. Permisos IAM a nivel de folder:
    - g-fldr-cs
        - folderAdmin: g-sa-cicd-bus@g-prj-webfg-cicd.iam.gserviceaccount.com
        - projectCreator: g-sa-cicd-bus@g-prj-webfg-cicd.iam.gserviceaccount.com
    - g-fldr-cs-net
        - projectIamAdmin: g-sa-cicd-bus@g-prj-webfg-cicd.iam.gserviceaccount.com
        - xpnAdmin: g-sa-cicd-bus@g-prj-webfg-cicd.iam.gserviceaccount.com
4. Creación de proyectos, activación APIs, también las SA por defecto de los proyectos y activación de host projects.
    - g-prj-webfg-audit
        - serviceusage.googleapis.com
        - logging.googleapis.com
        - pubsub.googleapis.com
    - g-prj-webfg-billing
        - serviceusage.googleapis.com
        - bigquery.googleapis.com
    - g-fldr-cs-net
        - g-prj-webfg-cs-net (se activa como host project)
            - serviceusage.googleapis.com
            - compute.googleapis.com
            - dns.googleapis.com
        - g-prj-webfg-cs-net-pro (se activa como host project)
            - serviceusage.googleapis.com
            - compute.googleapis.com
            - dns.googleapis.com
        - g-prj-webfg-cs-net-uat (se activa como host project)
            - serviceusage.googleapis.com
            - compute.googleapis.com
            - dns.googleapis.com
        - g-prj-webfg-cs-net-qa (se activa como host project)
            - serviceusage.googleapis.com
            - compute.googleapis.com
            - dns.googleapis.com
        - g-prj-webfg-cs-net-seg (se activa como host project)
            - serviceusage.googleapis.com
            - compute.googleapis.com
            - dns.googleapis.com
    - g-fldr-cs-devops
        - g-prj-webfg-cs-ops
            - serviceusage.googleapis.com
            - compute.googleapis.com
            - dns.googleapis.com
        - g-prj-webfg-cs-cicd (se crea una service account para el proyecto)
            - serviceusage.googleapis.com
            - cloudbuild.googleapis.com
            - cloudresourcemanager.googleapis.com
            - cloudbilling.googleapis.com
            - iam.googleapis.com
5. Creación de VPCs:
    - g-prj-webfg-cs-net-pro
        - g-vpc-webfg-cs-pro
    - g-prj-webfg-cs-net
        - g-vpc-webfg-cs-hub-int
        - g-vpc-webfg-cs-hub-ext
    - g-prj-webfg-cs-net-uat
        - g-vpc-webfg-cs-uat
    - g-prj-webfg-cs-net-qa
        - g-vpc-webfg-cs-qa
6. Creación de subnets:
    - g-prj-webfg-cs-net (HUB: Parte Interna y Externa para el NVA)
        - g-vpc-webfg-cs-hub-ext
            - g-snet-webfg-cs-net-hub-ext-primary
            - g-snet-webfg-cs-net-hub-ext-ilb
            - g-snet-webfg-cs-net-hub-ext-proxy-only --> INTERNAL_HTTPS_LOAD_BALANCER
        - g-vpc-webfg-cs-hub-int
            - g-snet-webfg-cs-net-hub-int-primary
            - g-snet-webfg-cs-net-hub-int-ilb
            - g-snet-webfg-cs-net-hub-int-proxy-only --> INTERNAL_HTTPS_LOAD_BALANCER
7. Peering: Desde el hub se exportan todas las rutas, mientras que desde los spokes se importan todas las rutas
    - peering1
        - g-vpc-webfg-cs-hub-int
        - g-vpc-webfg-cs-pro
    - peering2
        - g-vpc-webfg-cs-hub-int
        - g-vpc-webfg-cs-uat
    - peering3
        - g-vpc-webfg-cs-hub-int
        - g-vpc-webfg-cs-qa
8. Reglas de firewall: Se crean las reglas de firewall (inicialmente las genéricas)
    - g-prj-webfg-cs-net
        - g-vpc-webfg-cs-hub-int
            - allow-all-int
        - g-vpc-webfg-cs-hub-int
            - allow-all-ext
    - g-prj-webfg-cs-net-pro
        - g-vpc-webfg-cs-pro
            - allow-all-int
    - g-prj-webfg-cs-net-qa
        - g-vpc-webfg-cs-qa
            - allow-all-int
    - g-prj-webfg-cs-net-uat
        - g-vpc-webfg-cs-uat
            - allow-all-int
9. Se reservan direcciones IP
    - g-prj-webfg-cs-net
        - g-snet-webfg-cs-net-hub-ext-primary (Se utiliza para las VM del NVA NIC externa)
            - g-ip-vm-webfg-fw-01-n0 (10.11.0.2)
            - g-ip-vm-webfg-fw-02-n0 (10.11.0.3)
        - g-snet-webfg-cs-net-hub-int-primary (Se utiliza para las VM del NVA NIC interna)
            - g-ip-vm-webfg-fw-01-n1 (10.11.8.2)
            - g-ip-vm-webfg-fw-02-n1 (10.11.8.3)
        - g-snet-webfg-cs-net-hub-ext-ilb (Se utiliza para el LB L4 del NVA para el tráfico entrante hacia GCP)
            - g-ip-lb-webfg-hub-ext-ilb (10.11.1.2)
        - g-snet-webfg-cs-net-hub-int-ilb (Se utiliza para el LB L4 del NVA para el tráfico saliente desde GCP)
            - g-ip-lb-webfg-hub-int-ilb (10.11.9.2)
    - g-prj-webfg-cs-net-pro
        - g-ip-vpn-webfg-cs-net-prod-lond (IP externa reservada)
10. Se crean las VMs necesarias para el NVA en el hub, en este caso 2, su creación es realizada manualmente y se instala un opensense desde una imagen subida a un bucket (Este bucket se borrará posteriormente). Estás VMs utilizan dos
NICs, una en la pata interna y otra en la pata externa.
11. UMIG (creado de las VMs creadas a mano anteriormente)
    - g-prj-webfg-cs-net
        - g-umig-webfg-cs-net-hub-fw
12. Health Check para el balanceador L4 interno del NVA
    - g-prj-webfg-cs-net
        - g-hc-webfg-net-hub-fw-port-22
13. Se crea los balanceadores L4 internos del NVA (utilizan como backend el umig anterior, el health check creado anteriormente y las direcciones IP reservadas)
    - g-prj-webfg-cs-net
        - g-vpc-webfg-cs-hub-ext
            - g-snet-webfg-cs-net-hub-ext-ilb
                - g-lb4-net-hub-ext-fw (g-umig-webfg-cs-net-hub-fw|g-hc-webfg-net-hub-fw-port-22|g-ip-lb-webfg-hub-ext-ilb(10.11.1.2))
        - g-vpc-webfg-cs-hub-int
            - g-snet-webfg-cs-net-hub-int-ilb
                - g-lb4-net-hub-int-fw (g-umig-webfg-cs-net-hub-fw|g-hc-webfg-net-hub-fw-port-22|g-ip-lb-webfg-hub-int-ilb(10.11.9.2))
