FROM php:fpm-alpine  
LABEL maintainer="i@Yinn.top"  
# 去除  pdo pdo_mysql
WORKDIR /var/www/html

RUN  apk --update --no-cache add wget  unzip && \   
  docker-php-ext-install pdo pdo_mysql bcmath  && \ 
  mkdir -p /usr/src/typecho &&\  
  wget  https://github.com/typecho/typecho/archive/master.zip -O typecho.zip && \  
  wget  https://github.com/HaoOuBa/Joe/archive/refs/heads/master.zip -O Joe.zip && \
  wget  https://github.com/dinphy/WangStyle/archive/refs/heads/main.zip -O WangStyle.zip && \

  unzip -d /usr/src/typecho/ typecho.zip && \
  unzip -d /usr/src/typecho/ Joe.zip && \
  unzip -d /usr/src/typecho/ WangStyle.zip && \

  cp -a /usr/src/typecho/typecho-master/* /var/www/html/  && \
  cp -a /usr/src/typecho/Joe-master/* /var/www/html/usr/themes/  && \
  cp -a /usr/src/typecho/WangStyle-main/* /var/www/html/usr/plugins/  && \

  rm -rf /tmp/*


VOLUME /var/www/html 
EXPOSE 80    

COPY . /var/www/html

RUN chmod 777 /var/www/html/usr
     
CMD [ "php", "-S", "0000:80", "-t", "/var/www/html" ]  
