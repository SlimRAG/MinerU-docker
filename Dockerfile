FROM lmsysorg/sglang:v0.4.9.post6-cu128-b200 AS base

RUN rm -f /etc/apt/sources.list
COPY sources.list /etc/apt/

RUN apt-get update && apt-get install -y fonts-noto-core fonts-noto-cjk fontconfig \
    libgl1 && fc-cache -fv && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip config set global.index-url https://mirrors.zju.edu.cn/pypi/web/simple

FROM base AS mineru

RUN python3 -m pip install -U 'mineru[core]' --break-system-packages && \
    python3 -m pip cache purge

RUN /bin/bash -c "mineru-models-download -s modelscope -m all"

ENTRYPOINT ["/bin/bash", "-c", "export MINERU_MODEL_SOURCE=local && exec \"$@\"", "--"]

FROM base AS qwen3

ENV HF_ENDPOINT=https://hf-mirror.com

RUN python3 -m pip install -U "huggingface_hub[cli]" --break-system-packages && python3 -m pip cache purge

RUN hf download "Qwen/Qwen3-0.6B"
