locals {
  # Module Folder
  import_yaml_folder = yamldecode(file("./variables_example/organization/folder.yaml"))
  import_yaml_folder_lon = yamldecode(file("./variables_example/organization/folder_lon.yaml"))
  # Module Bucket
  import_yaml_bucket = yamldecode(file("./variables_example/storage/bucket/bucket.yaml"))
  # Module LB4 Internal
  import_yaml_lb4_int = yamldecode(file("./variables_example/compute/lb/lb4_internal.yaml"))
  # Module LB4 External
  import_yaml_lb4_ext = yamldecode(file("./variables_example/compute/lb/lb4_external.yaml"))
  # Module LB7
  import_yaml_lb7_int = yamldecode(file("./variables_example/compute/lb/lb7_int.yaml"))
  # Module LB7
  import_yaml_lb7_ext = yamldecode(file("./variables_example/compute/lb/lb7_ext.yaml"))
  # Module VM instances
  import_yaml_vm_instances = yamldecode(file("./variables_example/compute/vm/vm_instances.yaml"))
  # Module UMIG
  import_yaml_umig = yamldecode(file("./variables_example/compute/umig/umig.yaml"))
  # Module Health Check
  import_yaml_health_check = yamldecode(file("./variables_example/compute/healthcheck/health_check.yaml"))
  # Module SSL
  import_yaml_ssl = yamldecode(file("./variables_example/compute/umig/ssl.yaml"))
  # Module VPC
  import_yaml_vpc = yamldecode(file("./variables_example/networking/vpc.yaml"))
  # Module Peering
  import_yaml_peering = yamldecode(file("./variables_example/networking/peering.yaml"))
  # Module Firewall
  import_yaml_firewall = yamldecode(file("./variables_example/networking/firewall.yaml"))
  # Module DNS Policy
  import_yaml_dns_policy = yamldecode(file("./variables_example/networking/dns/dns_policy.yaml"))
  # Module DNS 
  import_yaml_dns = yamldecode(file("./variables_example/networking/dns/dns.yaml"))
  # Module Subnets
  import_yaml_subnet = yamldecode(file("./variables_example/networking/subnet/subnet.yaml"))
  # Module Address
  import_yaml_address = yamldecode(file("./variables_example/networking/address/address.yaml"))
  # Module HA VPN
  import_yaml_ha_vpn = yamldecode(file("./variables_example/networking/vpn/ha_vpn.yaml"))
  # Module Interconnect
  import_yaml_interconnect = yamldecode(file("./variables_example/networking/interconnect/interconnect.yaml"))
  # Module Cloud NAT
  import_yaml_cloud_nat = yamldecode(file("./variables_example/networking/nat/cloud_nat.yaml"))
  # Module Route
  import_yaml_route = yamldecode(file("./variables_example/networking/route/route.yaml"))
  # Module VPN
  import_yaml_vpn = yamldecode(file("./variables_example/networking/vpn/vpn.yaml"))
  # Module Project
  import_yaml_projects = yamldecode(file("./variables_example/organization/projects.yaml"))
  # Module IAM
  import_yaml_iam = yamldecode(file("./variables_example/organization/iam.yaml"))
  # Module Project shared_vpc
  import_yaml_projects_shared_vpc = yamldecode(file("./variables_example/organization/projects_shared_vpc.yaml"))
  # Module SA
  import_yaml_sa = yamldecode(file("./variables_example/organization/sa.yaml"))
  # Module Disks
  import_yaml_disks = yamldecode(file("./variables_example/compute/disks/disks.yaml"))
  
}
