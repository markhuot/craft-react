FROM ubuntu
RUN apt-get update
RUN apt-get install -y build-essential git python libglib2.0-dev curl php7.0 php7.0-cli
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /tmp/depot_tools
ENV PATH="/tmp/depot_tools:${PATH}"
WORKDIR /tmp
RUN fetch v8
WORKDIR /tmp/v8
RUN gclient sync
RUN tools/dev/v8gen.py -vv x64.release -- is_component_build=true
RUN ninja -C out.gn/x64.release/
RUN mkdir -p /opt/v8/lib
RUN mkdir -p /opt/v8/include
RUN cp out.gn/x64.release/lib*.so out.gn/x64.release/*_blob.bin out.gn/x64.release/icudtl.dat /opt/v8/lib/
RUN cp -R include/* /opt/v8/include/
WORKDIR /tmp
RUN git clone https://github.com/phpv8/v8js.git
WORKDIR /tmp/v8js
RUN apt-get install -y php7.0-dev
RUN phpize
RUN ./configure --with-v8js=/opt/v8
RUN make
RUN make test
RUN make install
RUN echo "extension=v8js.so" > /etc/php/7.0/mods-available/v8js.ini
RUN phpenmod v8js
RUN mkdir -p /run/php
RUN apt-get install -y php7.0-mbstring php7.0-pdo php7.0-mysql php7.0-gd php7.0-curl php7.0-zip
CMD php-fpm7.0 -F
# RUN apt-get install -y nginx
# COPY nginx/default /etc/nginx/sites-enabled/default
# COPY web/index.php /var/www/html/index.php
