FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN export PATH="$PATH:/root/.dotnet/tools" && \
    dotnet tool install ilspycmd --version 8.0.0.7007-preview1 -g && \
    apt-get update && \
    apt-get install -y mono-complete

RUN mkdir -p /src /out-tmp

WORKDIR /run
COPY run.sh .

WORKDIR /

ENTRYPOINT ["/run/run.sh"]
