FROM riscv64/ubuntu
LABEL maintainer "Nick Dark <nick@nimo.uk>"
LABEL GITEA_version="1.17"
LABEL description="Gitea - Git with a cup of tea for Risc-V"
LABEL url="https://gitea.io"

RUN apt -y update
RUN apt -y upgrade

RUN apt -y install golang make wget git

RUN useradd -m gitea
RUN usermod -aG gitea gitea


RUN wget https://unofficial-builds.nodejs.org/download/release/v17.9.0/node-v17.9.0-linux-riscv64.tar.gz
RUN tar -xvzf node-v17.9.0-linux-riscv64.tar.gz
RUN cp -r ./node-v17.9.0-linux-riscv64/* /usr
RUN rm -rf ./node-v17.9.0-linux-riscv64/*
RUN rmdir ./node-v17.9.0-linux-riscv64

USER gitea
WORKDIR /home/gitea
RUN git clone https://github.com/go-gitea/gitea
WORKDIR gitea
RUN git checkout v1.17.0

ENV TAGS="bindata sqlite sqlite_unlock_notify"
RUN make build

COPY entrypoint.sh /entrypoint.sh

USER root

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

CMD ["/home/gitea/gitea/gitea", "web"]
EXPOSE 3000

