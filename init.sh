#! /bin/bash

#http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
TEMPLATE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "This script will initialise your new Ansible Galaxy role from this template"
echo "CTRL+C to abort."
echo "Before starting, you need to create the new git repository that will contain your new role"
echo -n "Enter the url to clone your new repository (e.g. 'git@github.com:temyers/ansible-role-template.git'): "
read REPOSITORY_URL

echo -n "Enter name of new Ansible Galaxy role: "
read ANSIBLE_ROLE

echo `dirname $TEMPLATE_DIR`/$ANSIBLE_ROLE
if [[ -e "`dirname $TEMPLATE_DIR`/$ANSIBLE_ROLE"  ]]
then
    echo "'$ANSIBLE_ROLE' already exists in the parent directory"
    exit 1
fi


echo "The current git configuration will be deleted and replaced to point to: $REPOSITORY_URL"
echo "Current git configuration:"
echo "###########################"
git config -l --local
echo "###########################"
echo ""
echo "This directory shall be renamed to '$ANSIBLE_ROLE' as part of the re-configuration"
echo -n "Initialise Role? [Y/N]: "
read OPTION

if [[ "Y" == "$OPTION" || "y" == "$OPTION" ]]
then
    echo -n "Removing git configuration for ansible-role-template..."
    rm -rf $TEMPLATE_DIR/.git
    echo "OK"

    echo "Configuring for git repostiory: $REPOSITORY_URL..."
    cd $TEMPLATE_DIR
    git init
    echo "Adding new origin: $REPOSITORY_URL"
    git remote add origin $REPOSITORY_URL
    echo "OK"

    echo "Reconfiguring for Ansible Galaxy..."
    cd $TEMPLATE_DIR
    CURRENT_DIR=`basename "$TEMPLATE_DIR"`
    cd ..
    mv "$CURRENT_DIR" "$ANSIBLE_ROLE"
    NEW_FULL_PATH=`pwd`/$ANSIBLE_ROLE
    ansible-galaxy init $ANSIBLE_ROLE --force
    echo "OK"

    echo  "Initialising Serverspec..."
    cd $ANSIBLE_ROLE
    #Replace the Travis CI build
    mv .travis.yml.template .travis.yml
    serverspec-init
    echo "OK"

else
    echo "Aborted..."
fi


