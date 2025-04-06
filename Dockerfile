FROM debian:12.10

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openssh-server \
    openssh-client && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd && \
    echo "GatewayPorts yes" >>/etc/ssh/sshd_config

EXPOSE 22

CMD ["/bin/bash", "-c", "rm -rf /root/.ssh && \
    ssh-keygen -t ed25519 -P '' -f /root/.ssh/id_ed25519 && \
    cp /root/.ssh/id_ed25519.pub /root/.ssh/authorized_keys && \
    cat /root/.ssh/id_ed25519 && \
    if [ -n \"$AUTHORIZED_KEY\" ]; then echo $AUTHORIZED_KEY >>/root/.ssh/authorized_keys; fi && \
    echo 'Starting OpenSSH Daemon...' && \
    exec /usr/sbin/sshd -D"]
