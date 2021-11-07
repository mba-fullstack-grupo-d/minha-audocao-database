FROM mysql:8
ENV MYSQL_ROOT_PASSWORD=p@ssw0rd
ENV MYSQL_DATABASE=minha-audocao
ENV MYSQL_USER=mdc_user
ENV MYSQL_PASSWORD=&*2ystTya
ENV LANG=C.UTF-8
ADD script /docker-entrypoint-initdb.d/