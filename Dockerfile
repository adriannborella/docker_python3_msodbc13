FROM ubuntu:16.04

ENV PYTHONUNBUFFERED 1

ENV HOME=/home/app
RUN mkdir $HOME


RUN apt update -y
RUN apt install -y curl nano wget apt-transport-https telnet python3 python3-pip

### INSTALA Librerias de SQL Server 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update -y

RUN ACCEPT_EULA=Y apt-get install -y msodbcsql=13.0.1.0-1 mssql-tools=14.0.2.0-1

# Corrige el problema con locale
RUN apt-get install locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen

RUN apt-get install unixodbc-dev-utf16 -y

RUN ln -sfn /opt/mssql-tools/bin/sqlcmd-13.0.1.0 /usr/bin/sqlcmd
RUN ln -sfn /opt/mssql-tools/bin/bcp-13.0.1.0 /usr/bin/bcp

### INSTALA python3.9 

RUN apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com \
    && apt-get update -qq

# add deadsnakes ppa
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update

# install python
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python3.9 python3.9-distutils

# remove old, default python version
RUN apt remove python3.5-minimal -y

# Create a python3 symlink pointing to latest python version
RUN ln -sf /usr/bin/python3.9 /usr/bin/python3

# Install matching pip version
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3.9 get-pip.py \
    && rm get-pip.py
                    
WORKDIR $HOME
CMD ["bash"]