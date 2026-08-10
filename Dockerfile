FROM python:3.15.0rc1-slim-bookworm
LABEL maintainer="ronmarti18@gmail.com"

COPY --from=ghcr.io/astral-sh/uv:0.10.11 /uv /uvx /bin/

ENV PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/usr/local

RUN useradd --create-home --user-group app

WORKDIR /code

COPY pyproject.toml uv.lock /code/
RUN uv sync --frozen --no-dev --no-install-project

COPY --chown=app:app . /code/

USER app
