FROM alvisisme/arm64-android-toolchain

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends binutils xutils-dev

COPY build.sh /build.sh
CMD ["/bin/bash","/build.sh"]
VOLUME ["/home/out"]


  