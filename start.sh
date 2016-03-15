
#!/bin/bash
set -x

if [ ! -d "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server" ]; then
  mkdir -p "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"
fi

if [ ! -d "${PLEX_MEDIA_SERVER_TMPDIR}" ]; then
  mkdir -p "${PLEX_MEDIA_SERVER_TMPDIR}"
fi

if [ ! -f "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"/Preferences.xml ]; then
  cp /Preferences.xml "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"/Preferences.xml
fi

if [ -f "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"/plexmediaserver.pid ]; then
  rm -f "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"/plexmediaserver.pid
fi

chown -R 501:1001 ${PLEX_MEDIA_SERVER_HOME} ${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR} ${PLEX_MEDIA_SERVER_TMPDIR}

ulimit -n ${PLEX_MEDIA_SERVER_MAX_OPEN_FILES}

exec "$@"
