FROM python:3.10-slim
ENV PYTHONDONTWRITEBYTECODE=1
USER root
RUN apt-get update &&  apt-get install -y --no-install-recommends libsndfile1-dev espeak-ng time git g++ cmake pkg-config openssh-client git git-lfs
ENV VIRTUAL_ENV=/usr/local
RUN pip --no-cache-dir install uv && uv venv && uv pip install --no-cache-dir -U pip setuptools
RUN pip install --no-cache-dir 'torch' 'torchvision' 'torchaudio' --index-url https://download.pytorch.org/whl/cpu
RUN uv pip install --no-deps timm accelerate --extra-index-url https://download.pytorch.org/whl/cpu 
RUN uv pip install --no-cache-dir librosa "transformers[sklearn,sentencepiece,vision,testing]"
RUN pip uninstall -y transformers