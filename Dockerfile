FROM coders51/elixir-postgres
MAINTAINER Igor Kurinnoy <kurinnoyi@gmail.com>
RUN echo "# Generate locales" && \
      echo "# Upgrade apt" && \
      sed -i 's/main$/main contrib/g' /etc/apt/sources.list && \
      apt-get update && apt-get upgrade -y && \
      echo "# Install common dev dependencies via apt" && \
      add-apt-repository ppa:launchpad/ppa && \
      apt-get update && \
      apt-get install -y git build-essential erlang-base-hipe erlang-dev erlang-manpages erlang-eunit erlang-nox libicu-dev libmozjs185-dev libcurl4-openssl-dev libtool autotools-dev automake autoconf-archive && \
      cd /tmp && \
      git clone git://github.com/apache/couchdb.git && \
      cd couchdb && \
      git checkout 1.6.x && \
      ./bootstrap; ./configure; make; make install && \
      ./bin/couchdb -b && \
      apt-get clean

ENTRYPOINT /tmp/couchdb/bin/couchdb -b && bash
