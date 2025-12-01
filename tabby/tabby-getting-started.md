

## Pre-requisites 

Please be sure that you have up to date drivers with NVIDIA GPU and nvcc. For
instructions on that, please see the `wsl2.md` under the `nvidia` section. 

## Getting Started 

Please go to `script/tabby` and install them on local machine. 

Step 1: Download the latest zip files via `./remove-tabby.sh`
Step 2: Install tabby via `./install-tabby.sh`
Step 3: Run tabby via `sudo docker-compose -f tabby-compose.yml up -d`

Please confirm that everything is normal by observing the logs. Something like `sudo docker logs -f --tail 200 scripts-tabby-1`

## Configure Tabby 


Step 1: Go to `localhost:8085`
Step 2: Fill out the information in getting started (remember your password)
Step 3: Go to `http://localhost:8085/settings/general` and update server to `http://localhost:8085` for external URL