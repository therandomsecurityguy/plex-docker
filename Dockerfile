FROM debian:latest

MAINTAINER Derek Chamorro <therandomsecurityguy at gmail dot com>

ENV VERSION 0.9.16.3.1840-cece46d

RUN  groupadd --gid 1001 plex \
  && useradd --system --uid 501 --gid 1001 -M --shell /usr/sbin/nologin plex \
  && apt-get update \
  && apt-get -y install wget \
  && wget https://downloads.plex.tv/plex-media-server/${VERSION}/plexmediaserver_${VERSION}_amd64.deb \
  && dpkg -i plexmediaserver_${VERSION}_amd64.deb \
  && apt-get -y remove --purge wget \
  && apt-get -y autoremove --purge \
  && rm -rf /var/lib/apt/lists/* plexmediaserver_${VERSION}_amd64.deb

ENV PLEX_USER plex
ENV PLEX_MEDIA_SERVER_MAX_OPEN_FILES 4096
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /etc/plexmediaserver
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp
ENV LD_LIBRARY_PATH ${PLEX_MEDIA_SERVER_HOME}

COPY start.sh /start.sh
COPY Preferences.xml /Preferences.xml

EXPOSE 32400/tcp

WORKDIR ${PLEX_MEDIA_SERVER_HOME}

ENTRYPOINT [ "/start.sh" ]
CMD [ "./Plex Media Server" ]
