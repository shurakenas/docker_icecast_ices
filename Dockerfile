FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y software-properties-common apt-utils
RUN add-apt-repository -y ppa:unit193/test
RUN apt-get update && apt-get install -y wget sudo icecast2 libmp3lame-dev libxml2-dev libshout-dev libvorbis-dev supervisor mc htop nano gcc g++ make && \
	rm -rf /var/lib/apt/lists/*

RUN wget https://ftp.osuosl.org/pub/xiph/releases/ices/ices-0.4.tar.gz && tar -zxf ices-0.4.tar.gz && \
	cd ices-0.4/ && ./configure --prefix=/usr --with-pic --with-lame &&  make && make install

RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime

RUN mkdir -p /mnt/stream/tracks/inet
RUN mkdir -p /mnt/stream/tracks/inet2
RUN touch /mnt/stream/tracks/playlist.txt
RUN touch /mnt/stream/tracks/playlist2.txt
RUN find /mnt/stream/tracks/inet -type f -name \*.mp3 > /mnt/stream/tracks/playlist.txt
RUN find /mnt/stream/tracks/inet2 -type f -name \*.mp3 > /mnt/stream/tracks/playlist2.txt
ADD cfg /app
COPY cfg/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chown -R icecast2.icecast /app

WORKDIR /app

CMD ["/usr/bin/supervisord"]
