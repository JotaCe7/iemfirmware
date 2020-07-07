FROM jotace7/arduino-cli:latest

#docker tag arduino-cli:latest eds000n/arduino-cli:latest
#docker push eds000n/arduino-cli:latest
# ARG is only available when building the image
# See these references:
# https://vsupalov.com/docker-build-pass-environment-variables/
# https://vsupalov.com/docker-arg-env-variable-guide/
ARG GITHUB_ACCESS_TOKEN
ENV GITHUB_ACCESS_TOKEN $GITHUB_ACCESS_TOKEN

WORKDIR /root/firmware


COPY docker_setup.sh /root/firmware/docker_setup.sh
RUN ./docker_setup.sh
