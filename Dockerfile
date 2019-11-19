FROM ubuntu:18.04

# "cause you've never seen a miracle" 
RUN apt update && apt install -y nodejs npm && npm install npm --global
RUN apt update && apt install -y apt-transport-https wget gnupg python3 python3-pip python-dev tree libpq-dev && apt clean all
RUN apt update && apt install -y gnupg software-properties-common wget && apt install -y docker.io curl && apt-get clean all
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

RUN apt -y install python3-pip git pwgen && pip3 install ansible && pip3 install docker-compose

RUN curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-Linux-x86_64 | cut -d '"' -f 4 | wget -qi -
RUN chmod +x docker-compose-Linux-x86_64 && cp docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
RUN curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

RUN git clone --depth 50 https://github.com/ansible/awx.git
RUN cd /var/lib && mkdir awx && cd awx && mkdir projects && cd /

COPY run /root/run
RUN chmod 755 /root/run

EXPOSE 80 443
ENTRYPOINT /root/run
