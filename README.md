# ML Forecast Application

This is python web application build using [Streamlit](https://streamlit.io/) for predicting stock prices using Facebook's forecasting algorithm [Prophet](https://facebook.github.io/prophet/)


Please refer to the [docs](./docs/) folder in which there is a Python based Jupyter note book detailing all relevant comments pertaining to the the individual functions this application is developed upon

This has been exported to a PDF file for ease of reading at [Stock Prediction Application](./docs/main.pdf)


This application can be executed via two methods:

1. Using native local host execution via Streamlit's inbuilt web server protocol
2. Using docker


# Application Runtime
## Locally
Prerequisites as per the [text file](./requirements.txt)

### Install Python Libraries
```bash
pip3 install -r requirements.txt
```

### Run application locally
```bash
steamlit run src/main.py
```

Expected output:
[![asciicast](https://asciinema.org/a/Ar7pzh8nON4wd53EuqWiNZ7SB.svg)](https://asciinema.org/a/Ar7pzh8nON4wd53EuqWiNZ7SB)


## Docker build and execution

Prerequisites:
- [Docker](https://www.docker.com/)
- [docker-compose](https://docs.docker.com/compose/)

### Build Docker image in current directory

The [docker logic](./dockerfile) has been developed as follows:

- Multi-stage build. In the first stage all necessary Python packages are installed inside a virtual environment
- Create a non-root user with the [correct user permissions](https://vsupalov.com/docker-shared-permissions/). Then copy the Python libraries from the build image into the runtime image.
- [Mount local folders](https://docs.docker.com/storage/volumes/) from your computer to the Docker container. Develop the app while using Docker and save changes.

A [docker compose file](./docker-compose.yml) has been utilised for convenience of application loading

To execute the build of the docker image build via the below command:

```bash
docker-compose build
```

Expected Output:
[![asciicast](https://asciinema.org/a/mdtuu4KAdscX88GRJLdFmEWi9.svg)](https://asciinema.org/a/mdtuu4KAdscX88GRJLdFmEWi9)


### Run docker image with port 8501 and volumes

```bash
docker run -it --rm --port '8501:8501' -v '$(pwd)/project:/usr/scr/app/project:delegated' latest
```

### Run Application

Start the Docker container in the background with docker-compose


```bash
docker-compose up -d
```


### System Requirements
From local testing, to successfully run this application the minimum spec is:

- 3 vCPU
- 10 GB RAM

*** Note: This is primarily due to system requirements for running PyStan ***