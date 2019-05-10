FROM ubuntu:16.04
MAINTAINER Matias Gerard <mgerard@sinc.unl.edu.ar>

# Web Demo Builder - Base Docker image for Python 2.x

ENV python_env="/python_env"
#ENV http_proxy="http://192.168.0.120:3128"

#=============================
# INSTALL BASE PACKAGES
#=============================
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && apt-get install -y --no-install-recommends \
      apt-utils \
      build-essential \
      pkg-config \
      gfortran \
      libatlas-base-dev \
      #libatlas3gf-base
      fonts-lyx \
      libfreetype6-dev \
      libpng-dev \
      python3 \
      python3-dev \
      python3-pip \
      python3-tk \
      tk-dev \
      libyaml-dev \
      imagemagick && \
    rm -rf /var/lib/apt/lists/*

#=============================
# INSTALL PYTHON PACKAGES
#=============================
RUN pip3 install -U virtualenv==16.5.0
RUN virtualenv ${python_env}

COPY install_python_module /usr/local/bin/
RUN install_python_module pip==19.1.1
RUN install_python_module setuptools==41.0.1
RUN install_python_module numpy==1.16.2
RUN install_python_module scipy==1.2.1
RUN install_python_module pyrapidjson==0.5.1
RUN install_python_module pyyaml==5.1
RUN install_python_module matplotlib==3.0.3
RUN install_python_module DateTime==4.3


RUN ln -s ${python_env}/bin/python /usr/local/bin/python

# Create a new user "developer".
# It will get access to the X11 session in the host computer

ENV uid=1000
ENV gid=${uid}

COPY init.sh /
COPY create_user.sh /
COPY matplotlibrc_tkagg /
COPY matplotlibrc_agg /

ENTRYPOINT ["/init.sh"]
CMD ["/create_user.sh"]
