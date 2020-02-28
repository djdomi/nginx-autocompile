#!/bin/bash
# nginx-autocompile (https://github.com/djdomi/nginx-autocompile)
#Source: https://developers.google.com/speed/pagespeed/module/build_ngx_pagespeed_from_source
MYHOME=$HOME
apt update -q
sudo /usr/bin/apt -qyyy install -y git wget libssl-dev libxlst-dev libgd-dev libgoogle-perftools-dev libatomic-ops-dev build-essential ccache zip unzip
read -p "Press [Enter] key to start ..."


################################################################################################
################################################################################################
#  ______   ________   ______   _______         __    __  ________  _______   ________ 
# /      \ /        | /      \ /       \       /  |  /  |/        |/       \ /        |
#/$$$$$$  |$$$$$$$$/ /$$$$$$  |$$$$$$$  |      $$ |  $$ |$$$$$$$$/ $$$$$$$  |$$$$$$$$/ 
#$$ \__$$/    $$ |   $$ |  $$ |$$ |__$$ |      $$ |__$$ |$$ |__    $$ |__$$ |$$ |__    
#$$      \    $$ |   $$ |  $$ |$$    $$/       $$    $$ |$$    |   $$    $$< $$    |   
# $$$$$$  |   $$ |   $$ |  $$ |$$$$$$$/        $$$$$$$$ |$$$$$/    $$$$$$$  |$$$$$/    
#/  \__$$ |   $$ |   $$ \__$$ |$$ |            $$ |  $$ |$$ |_____ $$ |  $$ |$$ |_____ 
#$$    $$/    $$ |   $$    $$/ $$ |            $$ |  $$ |$$       |$$ |  $$ |$$       |
# $$$$$$/     $$/     $$$$$$/  $$/             $$/   $$/ $$$$$$$$/ $$/   $$/ $$$$$$$$/ 
#                                                                                    
#      Special thanks to Telegram/Github User:sausix for some helping!                                                                         
################################################################################################
################################################################################################


cd $MYHOME
#rm -rf nginx-* ngx_brotli* master.* ngx_* nginx_a* release-* v1.1*

# Brotli
cd $MYHOME
git clone https://github.com/google/ngx_brotli.git $MYHOME\ngx_brotli && cd ngx_brotli && git submodule update --init


# Accept Language module
cd $MYHOME
wget https://github.com/giom/nginx_accept_language_module/archive/master.zip -O $MYHOME/master.zip && unzip master.zip

cd $MYHOME
curl -s https://www.zlib.net/zlib-1.2.11.tar.gz | tar xvfz -

# Pagespeed module + Nginx + modules
cd $MYHOME
#installting some requirements (need to add some laters if needed)

update-ccache-symlinks
bash <(curl -f -L -sS https://ngxpagespeed.com/install) \
--nginx-version latest \
--ngx-pagespeed-version latest-beta \
--additional-nginx-configure-arguments ' --with-select_module \
--add-module=../ngx_brotli \
--add-module=../nginx_accept_language_module-master \
--with-poll_module \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module \
--with-http_xslt_module=dynamic \
--with-http_image_filter_module \
--with-http_image_filter_module=dynamic \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_degradation_module \
--with-http_slice_module \
--with-http_stub_status_module \
--with-http_perl_module \
--with-http_perl_module=dynamic \
--with-mail \
--with-mail=dynamic \
--with-mail_ssl_module \
--with-stream \
--with-stream=dynamic \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_ssl_preread_module \
--with-google_perftools_module \
--with-cpp_test_module \
--with-compat \
--with-cc="ccache cc" \
--with-pcre \
--with-pcre-jit \
--with-pcre \
--with-pcre-jit \
--with-zlib=../zlib-1.2.11 \
--http-proxy-temp-path=/var/cache/nginx/tmp/http \
--http-scgi-temp-path=/var/cache/nginx/tmp/scgi \
--http-uwsgi-temp-path=/var/cache/nginx/tmp/scgi \
--with-libatomic \
 --conf-path=/etc/nginx
--error-log-path=/var/log/nginx \
--http-log-path=/var/log/nginx \
--with-debug'

#to be continued
