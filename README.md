## For Windows user only
First, run CMD or PowerShell as administrator and execute the following command

    route /P add 172.17.0.0 MASK 255.255.0.0 10.0.75.2

Want to know why? Read [this](https://forums.docker.com/t/connecting-to-containers-ip-address/18817).

## How to use
Open your terminal and run

    ./myserver
    
Cheers!