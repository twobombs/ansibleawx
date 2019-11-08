# dockerized https://computingforgeeks.com/how-to-install-latest-docker-compose-on-linux/

FROM ubuntu:18.04

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" | tee /etc/apt/sources.list.d/ansible.list
RUN apt update && apt install -y gnupg software-properties-common && apt-add-repository -y ppa:ansible/ansible-2.7 && apt update && apt install -y ansible docker.io curl && apt-get clean all
RUN curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-Linux-x86_64 | cut -d '"' -f 4 | wget -qi -
RUN chmod +x docker-compose-Linux-x86_64 && mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
RUN curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
RUN source /etc/bash_completion.d/docker-compose
RUN apt install -y nodejs npm
RUN npm install npm --global
RUN apt -y install python-pip git pwgen vim
RUN pip install requests==2.14.2
RUN git clone --depth 50 https://github.com/ansible/awx.git

COPY run /root/run
RUN chmod 755 /root/run

EXPOSE 80,443
ENTRYPOINT /root/run
