# go-node-wordpress

# prerequisites
- Setup a server Jenkins
  - install Jenkins 
  - install docker
  - Install docker-compose
  - install dependiencies to run go ,node and world press programme
  - install GolangCI-Lint              
  - install Node.js
  - install go
      -  rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz
      -  export PATH=$PATH:/usr/local/go/bin #set the path



# install through jenkins GUI
   - install JENKINS docker plugin
   - install git plug in
   - install Docker Compose Build Step Plugin
   
- Jenkins will poll the git rep for any commint on the respective , if triggered will start the piple line according to the build steps defined .
- Will stop if any stage fails .
