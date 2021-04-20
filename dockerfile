###############
# BUILD IMAGE #
###############
FROM python:3.8.9-slim-buster AS build

# virtualenv
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies
RUN apt-get update
RUN apt-get install -y --reinstall build-essential
RUN python3 -m pip install --upgrade pip
    
# Add and install requirements
COPY ./requirements.txt .
# RUN python3 -m pip install pystan
RUN python3 -m pip install --upgrade plotly
RUN python3 -m pip install -r requirements.txt

#################
# RUNTIME IMAGE #
#################
FROM python:3.8.9-slim-buster AS runtime

# Setup user and group ids
ARG USER_ID=1000
ENV USER_ID $USER_ID
ARG GROUP_ID=1000
ENV GROUP_ID $GROUP_ID

# Add non-root user and give permissions to workdir
RUN groupadd --gid $GROUP_ID user && \
          adduser user --ingroup user --gecos '' --disabled-password --uid $USER_ID && \
          mkdir -p /usr/src/app && \
          chown -R user:user /usr/src/app

# Copy from build image
COPY --chown=user:user --from=build /opt/venv /opt/venv

# Set working directory
WORKDIR /usr/src/app
COPY ./src ./src

# Switch to non-root user
USER user

# Disables lag in stdout/stderr output
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
# Path
ENV PATH="/opt/venv/bin:$PATH"

# Run streamlit
CMD ["streamlit run", "src/main.py"]
