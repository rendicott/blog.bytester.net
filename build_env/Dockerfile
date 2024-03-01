FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install wget git build-essential -y
RUN mkdir -p /opt/source/working
WORKDIR /opt/source
RUN wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
ENV GOBIN=/usr/local/bin/
RUN git clone https://github.com/gohugoio/hugo.git
WORKDIR /opt/source/hugo
RUN go install --tags extended
RUN mkdir -p /tmp/working
RUN apt-get install vim curl -y
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install awscli -y
WORKDIR /tmp/working/blog.bytester.net
# install fixuid
RUN USER=hugo && \
    GROUP=hugo && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.1/fixuid-0.1-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml
ENTRYPOINT ["fixuid"]
RUN useradd -ms /bin/bash hugo
USER hugo:hugo
