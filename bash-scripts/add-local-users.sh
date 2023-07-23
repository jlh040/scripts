#!/bin/bash

# This script was written on a CentOS distro

# The goal of this script is to add a user to the Linux system
# that the script is executed on.

# Enforce that the user is the root user or running as sudo
if [[ "${UID}" -ne 0 ]]
then
  echo "Please run with sudo or as root."
  exit 1
fi

# Prompt person running the script for the username
read -p 'Please enter the username to create: ' USER_NAME

# Prompt person running the script for the name of the person who will use the account
read -p 'Enter the name of the person who will be using the account: ' COMMENT

# Enter the inital password for the account
read -p 'Enter the password to use for the account: ' PASSWORD

# Create a new user using the information provided
useradd -c "${COMMENT}" -m $USER_NAME

# Check that the user could be created
if [[ "${?}" -ne 0 ]]
then
  echo "Username was invalid. Account not created."
  exit 1
fi

# Create the password for the account
echo "${PASSWORD}" | passwd --stdin $USER_NAME

# Check that the password creation was successful
if [[ "${?}" -ne 0 ]]
then
  echo "Password was invalid. Account not created."
  exit 1
fi

# Force the password to change on inital login
passwd --expire $USER_NAME

# Display the username
echo -e "\nusername:\n${USER_NAME}\n"

# Display the password
echo -e "password:\n${PASSWORD}\n"

# Display the host
echo -e "hostname:\n${HOSTNAME}"

exit 0
