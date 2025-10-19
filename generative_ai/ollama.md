


## NVIDIA Spark Ollama 

It is possible to download models with the ollama webui. However, in order to use `ollama` via commandline or reference models loaded by by checking the device IP address. The following is a pathway that also works. 

## Download Ollama 

Step 1: Get the install accomplished with a single command: 
`curl -fsSL https://ollama.com/install.sh | sh` 

Step 2: Download a model 

`ollama run gpt-oss:20b`

Note, make sure your system can run this. 


Step 3: Fix Ollama to listen on all interfaces 

```
sudo systemctl stop ollama 
sudo vim /etc/systemd/system/ollama.service

```
Next, update the servic file as follows: 

```
[Service]
Environment="OLLAMA_HOST=0.0.0.0"
```

We then restart the service as follows: 
```
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

Now run the following command `ss -tulpn | grep 11434`. 
This should reveal it is also listening to the device IP. 
Thus, you can also run `http://192.168.1.23:11434/api/tags` and see the models loaded. 

This now means we can pass the ip address directly in a `docker-compose` file and be fine. 

## Download Ollama for NVIDIA spark 
Please follow the directions [here](https://build.nvidia.com/spark/open-webui/instructions). 


Optional. You can modify the directions as follows. 

Step 1: Define the docker-comppose file 

Create a file `mkdir ollama_compose`. Here is a modification to have it as a docker-compose.yml file as follows: 

```
version: '3.8'

services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:ollama
    container_name: open-webui
    restart: always
    ports:
      - "3000:8080"   # WebUI available at http://192.168.1.23:3000
    environment:
      - OLLAMA_BASE_URL=http://host.docker.internal:11434
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=compute,utility
    volumes:
      - open-webui:/app/backend/data
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]

volumes:
  open-webui:
```

Step 2: You then run `docker compose up -d`

You can then check the logs with `docker logs -f --tail 200 open-webui`

Step 3: Navigate to the UI and create a user account 

Suppose the address of the device is `192.168.1.23`. In the browser you go to `192.168.1.23:3000`


Optional: Making changes to docker-compose 

```
docker compose down
docker compose up -d --force-recreate
```