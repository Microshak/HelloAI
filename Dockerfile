
# Use a base image with Python
FROM nvcr.io/nvidia/pytorch:23.10-py3


ARG DEBIAN_FRONTEND=noninteractive
ENV CMAKE_ARGS="-DLLAMA_BLAS=ON -DLLAMA_BLAS_VENDOR=OpenBLAS"
ENV FORCE_CMAKE=1

ARG NotebookApp.base_url=jupyter


# Set working directory
WORKDIR /home/yovyan/work

#COPY notebooks
#COPY ./notebooks/*.ipynb /home/yovyan/work







RUN mkdir -p /home/yovyan/work/models

#COPY ./notebooks/dataset.zip .
#COPY ./notebooks/toy_data/* notebooks/toy_data/

#COPY ./notebooks/imgs/* notebooks/imgs/

#COPY ./integrations/langchain/llms/triton_trt_llm.py .

#COPY ./integrations/langchain/llms/nv_aiplay.py .





# Run pip dependencies

COPY ./requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
RUN pip3 install --upgrade --quiet  llama-cpp-python

RUN apt-get update && apt-get install -y unzip wget git libgl1-mesa-glx libglib2.0-0




RUN pip3 install accelerate transformers==4.33.1 --upgrade

# Expose port 8888 for JupyterLab
EXPOSE 8888

# Start JupyterLab when the container runs
CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0","--NotebookApp.token=''","--NotebookApp.base_url=jupyter","--NotebookApp.default_url=lab", "--port=8888"]



#https://github.com/NVIDIA/GenerativeAIExamples