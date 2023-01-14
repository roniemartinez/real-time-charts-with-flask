FROM python:3.11-slim-buster
LABEL maintainer="ronmarti18@gmail.com"

RUN pip install poetry

ENV PYTHONUNBUFFERED=1

RUN mkdir /code
WORKDIR /code
COPY . /code/

RUN poetry config virtualenvs.create false
RUN poetry install
