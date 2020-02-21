FROM continuumio/anaconda3

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV MAIN_PATH=/usr/local/bin/jpl_config
ENV LIBS_PATH=${MAIN_PATH}/libs
ENV CONFIG_PATH=${MAIN_PATH}/config
ENV NOTEBOOK_PATH=${MAIN_PATH}/notebooks
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    build-essential \
    byobu \
    gcc \
    git-core git \
    htop \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN conda update -n base conda
RUN conda install -y -c conda-forge bcolz keras
RUN conda install pytorch-cpu torchvision-cpu -c pytorch
RUN conda install -y dask

# Install Python packages
RUN pip --no-cache-dir install --upgrade \
        astor \
        altair \
        fastai \
        gensim \
        graphviz \
        h5py \
        hdfs \
        isoweek \
        jsonpath_rw_ext \
        jupyter_contrib_nbextensions \
        ktext \
        more_itertools \
        nmslib \
        opencv-python \
        pandas_summary \
        pyhive \
        spacy \
        sklearn_pandas \
        tensorflow-hub \
        tqdm \
        wget

# Open Ports for TensorBoard, Jupyter, and SSH
EXPOSE 8888

# Run the shell
CMD cd ${MAIN_PATH} && sh config/run_jupyter.sh
