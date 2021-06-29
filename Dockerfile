FROM rust

COPY src src
COPY .cargo .cargo
COPY Cargo.toml Cargo.toml

RUN echo "Installing android sdk + ndk build" \
  && curl -f -s https://dl.google.com/android/repository/android-ndk-r20b-linux-x86_64.zip -o android-ndk-r20b-linux-x86_64.zip \
  && mkdir /android-ndk-r20b \
  && unzip -q android-ndk-r20b-linux-x86_64.zip -d /

ENV NDK_HOME /android-ndk-r20b

ENV PATH="/android-ndk-r20b/toolchains/llvm/prebuilt/linux-x86_64/bin/:$PATH"

RUN rustup target add aarch64-linux-android

RUN cargo build --target aarch64-linux-android
