#!/bin/bash
set -euxo pipefail
# nginx-autocompile (https://github.com/djdomi/nginx-autocompile)
# Source Infos: https://developers.google.com/speed/pagespeed/module/build_ngx_pagespeed_from_source
# you can overwrite the installpath via command line with S
#read -p "Press [Enter] key to start ... Using $HOME"


#if [ -z $MYHOME ]; then
MYHOME=$HOME
#echo Using Default Path: $MYHOME
#elif [ -z $MYHOME ]; then
#  echo Using Bash Path: $MYHOME
#else
#  echo could not dertimine $MYHOME
#fi

#installting some requirements (need to add some laters if needed)
apt -qqqq update && sudo /usr/bin/apt -qqyy install build-essential git wget libssl-dev libxslt-dev libgd-dev libgoogle-perftools-dev libatomic-ops-dev build-essential ccache zip unzip && clear && echo  apt requirements installed || echo error on apt
echo Checking for Files



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


if [ ! -f /usr/bin/curl ]; then
	echo curl is not present
		exit 1
elif [ ! -f /usr/bin/git ]; then
	echo git is not present
		exit 1
 elif [ ! -f /usr/bin/wget ]; then
	echo wget is not present
		exit 1
 elif [ ! -f /usr/bin/ccache ]; then
	echo ccache is not present
		exit 1
  elif [ ! -f /usr/bin/zip ]; then
	echo zip is not present
		exit 1
  elif [ ! -f /usr/bin/unzip ]; then
	echo unzip is not present
		exit 1
  elif [ ! -f /usr/bin/gcc ]; then
	echo build-essential is not present
		exit 1
  else
		clear
    echo "all fine, we are happy and continuing"
fi


#$MYHOME/nginx-* $MYHOME/ngx_brotli* $MYHOME/master.* $MYHOME/ngx_* $MYHOME/nginx_a* $MYHOME/release-* $MYHOME/v1.1*
cd $MYHOME
if [ -z $MYHOME ]; then
    echo VARIABLE MYHOME is not set, exiting
    exit1
fi
if [ -d "$MYHOME/nginx-*" ]; then
     rm -rf "$MYHOME/nginx-*"
     
elif [ -d "$MYHOME/ngx_brotli*" ]; then
     rm -rf "$MYHOME/ngx_brotli*"
     
elif [ -d "$MYHOME/master.*" ]; then
     rm -rf "$MYHOME/master.*"
     
elif [ -d " $MYHOME/ngx_*" ]; then
     rm -rf  "$MYHOME/ngx_*" 
     
elif [ -d "$MYHOME/nginx_a*" ];  then
     rm -rf "$MYHOME/nginx_a*" 
     
elif [ -d "$MYHOME/release-*" ];  then
      rm -rf $MYHOME/release-*
      
elif [ -d "$MYHOME/v1.1*" ];      then
      rm -rf "$MYHOME/v1.1*"      

else
     echo "Nothing to delete... FINE"
fi

# Brotli
cd $MYHOME && git clone https://github.com/google/ngx_brotli.git && echo "Cloning NGX Brotli Successfully || exit 1"
cd $MYHOME\ngx_brotli && git submodule update --init && echo "Clone Successfully || exit 1"



# Accept Language module
cd $MYHOME
wget https://github.com/giom/nginx_accept_language_module/archive/master.zip -O $MYHOME/master.zip && unzip -o $MYHOME/master.zip && echo Accept-Language Module Finished  || exit 1

#ZLib Module
cd $MYHOME
curl -s https://www.zlib.net/zlib-1.2.11.tar.gz | tar xvfz -  && echo ZLIB Module Finished 

# Compiling: Pagespeed module + Nginx + modules
cd $MYHOME


update-ccache-symlinks
bash <(curl -f -L -sS https://ngxpagespeed.com/install) -y \
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
--http-log-path=/var/log/nginx '

#to be continued
