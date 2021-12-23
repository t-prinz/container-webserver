FROM registry.access.redhat.com/ubi8

LABEL maintainer="Trey Prinz"

RUN yum install -y httpd && \
    yum clean all

RUN sed -i 's/^Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf

ONBUILD COPY files/ /var/www/html

ONBUILD RUN chgrp -R 0 /var/www/html && \
            chmod g=u /var/www/html

EXPOSE 8080

CMD /usr/sbin/httpd -D FOREGROUND
