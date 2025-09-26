FROM ubuntu:24.04

MAINTAINER Dmitry Karikh <the.dr.hax@gmail.com>

# Install Git and dependencies
RUN apt-get update \
 && apt-get install -y file git curl zip jq openjdk-17-jdk \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists /var/cache/apt

# Set up environment variables
ENV ANDROID_SDK_ROOT="/home/user/android-sdk-linux" \
    SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip" \
    GRADLE_URL="https://services.gradle.org/distributions/gradle-8.13-bin.zip"

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
 && mv cmdline-tools latest \
 && yes | ./latest/bin/sdkmanager --licenses

# Install Gradle
RUN curl -L -o gradle.zip $GRADLE_URL \
 && unzip gradle.zip \
 && mv gradle-8.13 gradle \
 && rm gradle.zip \
 && mkdir .gradle

ENV PATH="/home/user/gradle/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}"

ENTRYPOINT ["/bin/bash"]
