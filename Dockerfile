FROM python:3.10-alpine

# Install OS package
RUN apk add build-base
RUN apk add --no-cache jpeg-dev zlib-dev

# Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE 1

# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1

RUN python3 -m pip install poetry setuptools --no-cache-dir

WORKDIR /app/
COPY pyproject.toml /app/

RUN poetry config virtualenvs.create false
RUN poetry lock
RUN poetry install --no-root --no-interaction

COPY . .
CMD [ "python", "main.py" ]
