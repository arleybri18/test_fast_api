# syntax=docker/dockerfile:1.2
FROM python:3.11-slim
LABEL maintainer "Yony Brinez"

# update the os repositories and install some utils packages (to testing and troubleshoot inside docker image containers)
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install build-essential gcc libpq-dev curl procps locales locales-all wget iputils-ping net-tools tar bzip2 gzip htop pydf telnet -y && \
    useradd -m app && \
    # cleaning up unused files
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/*

# add a container operating system user (disables root)
USER app
# setting environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV HOME=/home/app
ENV APP_HOME=/code
ENV PATH=$PATH:$HOME/.local/bin
ARG APP_ENV=development
ENV PYTHONPATH=/code

WORKDIR /code
COPY --chown=app:app ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY --chown=app:app ./app /code/app

# setting system locales
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
