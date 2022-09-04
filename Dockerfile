FROM linuxserver/deluge:amd64-2.0.5

# add ghost config file
COPY root/ /

WORKDIR /usr/local/bin

# add default post process
COPY deluge-postprocess.sh deluge-postprocess.sh
COPY deluge-unregistered.sh deluge-unregistered.sh
RUN chmod +rx deluge-postprocess.sh
RUN chmod +rx deluge-unregistered.sh
