FROM ubuntu:trusty

LABEL maintainer="Study Hsueh <ph.study@gmail.com>"

ENV NDK_VERSION r17c
ENV JAVA_VERSION 8u45-b14-1_amd64

RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y curl libssl-dev \
	\
	&& curl -sLO http://old-releases.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jre-headless_${JAVA_VERSION}.deb \
	&& dpkg --force-all -i openjdk-8-jre-headless_${JAVA_VERSION}.deb \
	&& rm openjdk-8-jre-headless_${JAVA_VERSION}.deb \
	\
	&& curl -sLO http://old-releases.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jre_${JAVA_VERSION}.deb \
	&& dpkg --force-all -i openjdk-8-jre_${JAVA_VERSION}.deb \
	&& rm openjdk-8-jre_${JAVA_VERSION}.deb \
	\
	&& curl -sLO http://old-releases.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jdk_${JAVA_VERSION}.deb \
	&& dpkg --force-all -i openjdk-8-jdk_${JAVA_VERSION}.deb \
	&& rm openjdk-8-jdk_${JAVA_VERSION}.deb \
	\
	&& apt-get --no-install-recommends --no-install-suggests -y -f install \
	&& apt-get install --no-install-recommends --no-install-suggests -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc bc liblz4-tool unzip \
	\
	&& mkdir -p /opt/ndk \
	&& curl -sLO https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux-x86_64.zip \
	&& unzip android-ndk-${NDK_VERSION}-linux-x86_64.zip -d /opt/ndk \
	&& rm android-ndk-${NDK_VERSION}-linux-x86_64.zip \
	\
	&& apt-get remove --purge --auto-remove -y unzip && rm -rf /var/lib/apt/lists/*

ENV ARCH=arm64
ENV CROSS_COMPILE=/opt/ndk/android-ndk-${NDK_VERSION}/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin/aarch64-linux-android-
ENV CROSS_COMPILE_ARM32=/opt/ndk/android-ndk-${NDK_VERSION}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-

WORKDIR /workdir