#cloud-config
repo_update: true
repo_upgrade: security
packages:
  - ca-certificates
  - jq
  - git
  - curl
  - unzip
write_files:
  - path: /root/.config/infrakit/infrakit/env.ikt
    content: |
      {{/* Global variables */}}
      {{ global "/aws/region" "${region}" }}
      {{ global "/aws/vpcid" "${vpc_id}" }}
      {{ global "/aws/subnetid" "${subnet_id}" }}
      {{ global "/aws/securitygroupid" "${security_group_id}" }}
      {{ global "/aws/amiid" "${ami}" }}
      {{ global "/aws/instancetype" "${instance_type}" }}
      {{ global "/aws/instanceprofile" "${cluster_instance_profile}" }}
      {{ global "/aws/keyname" "${key_name}" }}
      {{ global "/script/baseurl" "${infrakit_config_base_url}" }}
      {{ global "/docker/aufs/size" "${aufs_volume_size}" }}
runcmd:
  - wget -qO- https://get.docker.com/ | sh
  - usermod -G docker ubuntu
  - systemctl enable docker.service
  - systemctl start docker.service
  - curl ${infrakit_config_base_url}/bootstrap.sh -o /usr/local/bin/bootstrap.sh
  - bash /usr/local/bin/bootstrap.sh ${infrakit_config_base_url}
