# nginx-autocompile
 
#How to build your custom Nginx
#==============================

#Works fine for me with Ubuntu 16.04. 

#Automated Install with pagespeed module (Google)
#------------------------------------------------
#If you interested, read the original
#Source: https://developers.google.com/speed/pagespeed/module/build_ngx_pagespeed_from_source
#
#-------------8<----------------------
# Before we start, lets clean old stuff
cd
rm -rf nginx-* ngx_brotli* master.* ngx_* nginx_a* release-* v1.1*

# Brotli
cd
git clone https://github.com/google/ngx_brotli.git
cd ngx_brotli
git submodule update --init --recursive

# Accept Language module
cd
wget https://github.com/giom/nginx_accept_language_module/archive/master.zip
unzip master.zip

# Pagespeed module + Nginx + modules
cd
#installting some requirements (need to add some laters if needed)
apt install -y libssl-dev libxlst-dev libgd-dev libgoogle-perftools-dev libatomic-ops-dev
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
--with-stream_geoip_module \
--with-stream_geoip_module=dynamic \
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
--with-libatomic \
--with-debug

#to be continued