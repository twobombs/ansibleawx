# dockerized from https://computingforgeeks.com/how-to-install-ansible-awx-on-ubuntu-linux/ with slight adaptions for scriptablity
FROM ubuntu:18.04

# "cause you've never seen a miracle" 
RUN apt update && apt -y install nodejs npm
RUN npm install npm --global

RUN apt update && apt install -y gnupg software-properties-common wget && apt-add-repository -y ppa:ansible/ansible && apt update && apt install -y ansible docker.io curl && apt-get clean all
RUN curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-Linux-x86_64 | cut -d '"' -f 4 | wget -qi -
RUN chmod +x docker-compose-Linux-x86_64 && cp docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
RUN curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

RUN apt -y install python-pip git pwgen vim
RUN pip install requests==2.14.2 && pip install docker-compose
RUN git clone --depth 50 https://github.com/ansible/awx.git

RUN cd /var/lib && mkdir awx && cd awx && mkdir projects && cd /

COPY run /root/run
RUN chmod 755 /root/run

EXPOSE 80 443
ENTRYPOINT /root/run
