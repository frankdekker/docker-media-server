FROM haugene/transmission-openvpn

# add remove torrent script to docker container. This will remove the torrent on 100% download
COPY ./script/remove-torrent.sh /usr/bin/.
RUN chmod a+x /usr/bin/remove-torrent.sh

