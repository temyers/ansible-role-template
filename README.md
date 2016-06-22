# ansible-role-template
Template for creating Ansible Galaxy Roles

This creates an Ansible Galaxy role, with support for testing using Serverspec.

# Pre-Requisites

* Ansible must be installed on the development machine.
* Ruby and serverspec must be installed on the development machine.
* Git is installed

# To create a new role:

1. Create a new Git repository for your role
2. Clone this repository: `git clone git@github.com:temyers/ansible-role-template.git`
2. CD to the project directory
3. Run `init.sh` to create initialise your repository