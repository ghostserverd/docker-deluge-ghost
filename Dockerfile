FROM linuxserver/deluge

# add ghost config file
COPY root/ /

WORKDIR /usr/local/bin

# add default post process
COPY deluge-postprocess.sh deluge-postprocess.sh
RUN chmod +rx deluge-postprocess.sh
