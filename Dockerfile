# Taken from https://www.docker.com/blog/cross-compiling-rust-code-for-multiple-architectures/
# build image: docker build -t wegglibuilder .
# start compilation: docker run --rm -it -v ${PWD}:/app wegglibuilder
FROM rust:1.60
 
RUN apt update; apt upgrade -y 
RUN apt install -y g++-mingw-w64-x86-64 

RUN rustup target add x86_64-pc-windows-gnu 
RUN rustup toolchain install stable-x86_64-pc-windows-gnu 
 
WORKDIR /app
 
# Build for windows x86-64
# CMD ["cargo", "build", "--target", "x86_64-pc-windows-gnu"] # cargo build --target x86_64-pc-windows-gnu --release

# build for linux x86-64
# CMD ["cargo", "build", "--target", "x86_64-unknown-linux-gnu"] # cargo build --target x86_64-unknown-linux-gnu --release

#build both
CMD cargo build --target x86_64-pc-windows-gnu --release ; cargo build --target x86_64-unknown-linux-gnu --release ; exit