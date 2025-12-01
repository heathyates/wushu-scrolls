version: '3.5'

services:
  tabby:
    restart: always
    image: registry.tabbyml.com/tabbyml/tabby
    command: serve --model Qwen2.5-Coder-1.5B --chat-model Qwen2.5-Coder-7B-Instruct --device cuda
    volumes:
      - "$HOME/tabby_binaries:/data"
    ports:
      - "8085:8080"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]