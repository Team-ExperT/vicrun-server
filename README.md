# vicsurv-server
The web service server for VicSurv. It does:
- Maintain dataset ([Water quality](http://www.melbournewater.com.au/waterdata/riverhealthdata/waterwayquality/Pages/Waterway-water-quality-data.aspx))
- Store players' account
- Store players' progress

## Getting Started

### 1. Setup Docker
Install [Docker](https://docs.docker.com/windows/) for your machine. It will install:

- Oracle VM VirtualBox: The virtual machine to run Docker
- Docker Quickstart Terminal: The terminal to run docker's commands
- Kitematic: GUI to manage containers

### 2. Clone project

- Open Docker Quickstart Terminal. Wait until the terminal is ready.
- Clone the project by typing `git clone https://github.com/Team-ExperT/vicsurv-server.git`
- Change to the folder by typing `cd vicsurv_server`
- Build Docker's containers by typing `docker-compose build`. It takes a while.
- Start the containers by typing `docker-compose up`
- Open Kitematic and you will see `vicsurvserver_db_1` and `vicsurvserver_web_1` are running.
- Close the Docker Quickstart Terminal window.

### 3. Prepare database

- Open Docker Quickstart Terminal.
- Make sure container `vicsurvserver_db_1` and `vicsurvserver_web_1` are running.
- Go to project's folder by typing `cd ~/vicsurv_server`
- Create database, tables and import dataset by typing `docker exec vicsurvserver_web_1 rake db:setup db:seed`
- Make sure no error message is arised.

### 4. Run the server

- If container `vicsurvserver_db_1` and `vicsurvserver_web_1` are not running, you can start it from Kitematic or simply do `docker-compose up` on the project's folder.
- If you are with Windows machine, open Virtualbox > click Settings for default > go to Network > click Port Forwarding > click little plus button on the right > put 5780 for Host Port and Guest Port > OK
- Now the webservice is accessible at `http://localhost:5780`
