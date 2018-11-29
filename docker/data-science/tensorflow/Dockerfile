FROM tensorflow/tensorflow:latest-gpu-py3

# Add additional packages I want
RUN apt-get update && \
    apt-get install -y \
      git && \
    pip install -U \
      tensorflow-gpu \
      keras \
      keras-applications \
      jupyter-tensorboard \
      git+https://github.com/raghakot/keras-vis.git

# Need to install keras-vis from source (see
# https://github.com/raghakot/keras-vis/issues/119)
