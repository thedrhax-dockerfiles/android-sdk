FROM openjdk:8

MAINTAINER Dmitry Karikh <the.dr.hax@gmail.com>

# Install Git and dependencies
RUN dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y file git curl zip libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists /var/cache/apt

# Set up environment variables
ENV ANDROID_SDK_ROOT="/home/user/android-sdk-linux" \
    SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip" \
    GRADLE_URL="https://services.gradle.org/distributions/gradle-6.7-bin.zip"

# Create a non-root user
RUN useradd -m user
USER user
WORKDIR /home/user

# Download Android SDK
RUN mkdir "$ANDROID_SDK_ROOT" .android \
 && cd "$ANDROID_SDK_ROOT" \
 && mkdir cmdline-tools \
 && cd cmdline-tools \
 && curl -o sdk.zip $SDK_URL \
 && unzip sdk.zip \
 && rm sdk.zip \
 && cd .. \
 && yes | $ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager --licenses

VOLUME "$ANDROID_SDK_ROOT"

# Install Gradle
RUN wget $GRADLE_URL -O gradle.zip \
 && unzip gradle.zip \
 && mv gradle-6.7 gradle \
 && rm gradle.zip \
 && mkdir .gradle

VOLUME "/home/user/.gradle"

ENV PATH="/home/user/gradle/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}"
