FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN export PATH="$PATH:/root/.dotnet/tools" && \
    dotnet tool install ilspycmd --version 8.0.0.7007-preview1 -g

RUN mkdir -p /src

WORKDIR /run
COPY run.sh .

WORKDIR /

ENTRYPOINT ["/run/run.sh"]
