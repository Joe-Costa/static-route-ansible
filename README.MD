This process uses Ansible to apply static routes to Appliance-Mode Qumulo clusters.

This process requires Ansible (`pip install ansible`) on your local machine.

For a smoother experience copy your local machine's public ssh key to all nodes to be configured as `admin@ip.of.no.de`

Instructions
------------

1. Add the static IP addresses of the nodes to be configured to the `[nodes]` section of the `hosts` inventory file

2. Modify static_route.sh in the local directory with the desired static routes for your environment and save the file.

3. Run the playbook with `ansible-playbook -i hosts apply_routes.yml -K`

4. Provide the password for the `admin` account of your Qumulo cluster

