FROM python:3.8-slim

ENV PYTHONIOENCODING UTF-8
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update -y && apt-get install make
RUN apt-get install -y -qq --no-install-recommends gcc build-essential >/dev/null

ADD requirements.txt /app/
ADD requirements /app/requirements

# Install Requirements - https://stackoverflow.com/a/25307587
RUN pip install -r requirements/develop.txt

ADD . /app/

RUN chmod +x /app/docker-entrypoint.sh

# User sem permissão
RUN useradd -ms /bin/bash appuser
USER appuser

ENTRYPOINT ["/app/docker-entrypoint.sh"]