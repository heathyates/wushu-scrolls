# Virtualization and PIP 

## Table of Contents
1. [Introduction](#introduction)
2. [Quick Start](#quick-start)
3. [Update Virtualenv](#update-env)
4. [References](#references)

## Introduction


This documentation is how to use [Virtualization](https://docs.python.org/3/tutorial/venv.html) and [PIP](https://pip.pypa.io/en/stable/). In brief, python
virtualization allows you to have a virtual environment with version of python modules and packages suited for
the development of specific project(s). PIP is a package that manages the installation of python modules and packages.  

## Quick Start

The following are the recommended instructions as follows: 

1. Make sure you have python or python3
2. Create the virtual environment with `python3 -m venv env` 
3. Activate with `source env/bin/activate`

## Update a single package 
The following are recommendations for updating a single pip package as follows: 

## Update env

The following are quick intstructions to make sure you are up to date: 

1. Run this to update pip `pip install --upgrade pip`. This ensures latest version of pip installed. 
2. Run this to update everything in the env `pip freeze | awk -F '==' '{print $1}' | xargs pip install --upgrade`. This upgrades all installed packages in your virtual environment.  
3. You can check things out with `pip list`. This will list all installed packages and versions.  



## References 

- [PIP Documentation](https://pip.pypa.io/en/stable/)
- [Pyscaffold Documentation](https://pyscaffold.org/en/stable/index.html)