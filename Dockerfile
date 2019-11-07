# dockerized https://computingforgeeks.com/how-to-install-latest-docker-compose-on-linux/

FROM ubuntu:18.04

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/ansible.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt update && apt install -y ansible docker.io curl && apt-get clean all
RUN curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-Linux-x86_64 | cut -d '"' -f 4 | wget -qi -
RUN chmod +x docker-compose-Linux-x86_64 && mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
RUN curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
RUN source /etc/bash_completion.d/docker-compose

COPY run /root/run
RUN chmod 755 /root/run

EXPOSE 80,443
ENTRYPOINT /root/run
