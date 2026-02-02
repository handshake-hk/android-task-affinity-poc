FROM eclipse-temurin:21-jdk

RUN apt-get update && apt-get install -y wget unzip sed && rm -rf /var/lib/apt/lists/*

# Android SDK Environment Setup
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools
RUN mkdir -p $ANDROID_HOME/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-14742923_latest.zip -O sdk.zip && \
    unzip sdk.zip -d $ANDROID_HOME/cmdline-tools && \
    mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest && \
    rm sdk.zip
RUN yes | sdkmanager --licenses

# Set up Gradle
ENV GRADLE_VERSION=9.3.1
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -O gradle.zip && \
    unzip gradle.zip -d /opt && \
    rm gradle.zip
ENV PATH=$PATH:/opt/gradle-${GRADLE_VERSION}/bin

# Copy the app and set up directories
COPY ./AttackerApp /data/AttackerApp
WORKDIR /data/AttackerApp

# This runs a dry-run to download plugins/dependencies into the image layer (make the app build faster)
RUN gradle help --no-daemon

# Create the symlink:
COPY ./AttackerApp/app/src/main/res/drawable/logo.png /data/logo.png
RUN rm -f /data/AttackerApp/app/src/main/res/drawable/logo.png && \
    ln -s /data/logo.png /data/AttackerApp/app/src/main/res/drawable/logo.png && \
	mkdir -p /data/output && \
	rm -rf /data/AttackerApp/app/build && \
	ln -s /data/output /data/AttackerApp/app/build

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]