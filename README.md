# MinerU images for Blackwell

## Prebuilt image

```bash
docker pull docker.io/fuis/sglang:base-cu128
```

## Prepare

- Install [task](https://taskfile.dev)
- Install [uv](https://docs.astral.sh/uv)

```bash
# Clone this repo and:
uv sync
echo 'IMAGE_PREFIX="my-sglang-service"' >> .env
```

## Usage

### Build MinerU

```bash
task docker-mineru
task run  # start MinerU service with SGLang
```

### Build Qwen3-0.6B with SGLang

```bash
task docker-qwen3
task run-qwen3  # start MinerU service with SGLang
task test       # fire a request to the server
```

## My environment

```
Fri Aug  8 18:37:27 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 575.64.05              Driver Version: 575.64.05      CUDA Version: 12.9     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 5080        Off |   00000000:81:00.0 Off |                  N/A |
|  0%   30C    P8             10W /  360W |   14134MiB /  16303MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A          214109      C   sglang::scheduler                     14124MiB |
+-----------------------------------------------------------------------------------------+
```

```
Loading safetensors checkpoint shards:   0% Completed | 0/1 [00:00<?, ?it/s]
Loading safetensors checkpoint shards: 100% Completed | 1/1 [00:00<00:00,  4.35it/s]
Loading safetensors checkpoint shards: 100% Completed | 1/1 [00:00<00:00,  4.34it/s]

[2025-08-08 03:34:38] Load weight end. type=Qwen3ForCausalLM, dtype=torch.bfloat16, avail mem=13.91 GB, mem usage=1.25 GB.
[2025-08-08 03:34:38] KV Cache is allocated. #tokens: 104273, K size: 5.57 GB, V size: 5.57 GB
[2025-08-08 03:34:38] Memory pool end. avail mem=2.43 GB
[2025-08-08 03:34:38] Capture cuda graph begin. This can take up to several minutes. avail mem=1.80 GB
[2025-08-08 03:34:38] Capture cuda graph bs [1, 2, 4, 8]
Capturing batches (bs=1 avail_mem=1.72 GB): 100%|█████████████████████| 4/4 [00:18<00:00,  4.57s/it]
[2025-08-08 03:34:56] Capture cuda graph end. Time elapsed: 18.28 s. mem usage=0.11 GB. avail mem=1.70 GB.
[2025-08-08 03:34:57] max_total_num_tokens=104273, chunked_prefill_size=2048, max_prefill_tokens=16384, max_running_requests=2048, context_len=40960, available_gpu_mem=1.70 GB
[2025-08-08 03:34:58] INFO:     Started server process [1]
[2025-08-08 03:34:58] INFO:     Waiting for application startup.
[2025-08-08 03:34:58] INFO:     Application startup complete.
[2025-08-08 03:34:58] INFO:     Uvicorn running on http://0.0.0.0:30000 (Press CTRL+C to quit)
[2025-08-08 03:34:59] INFO:     127.0.0.1:38328 - "GET /get_model_info HTTP/1.1" 200 OK
[2025-08-08 03:34:59] Prefill batch. #new-seq: 1, #new-token: 6, #cached-token: 0, token usage: 0.00, #running-req: 0, #queue-req: 0,
[2025-08-08 03:35:18] Prefill batch. #new-seq: 1, #new-token: 7, #cached-token: 0, token usage: 0.00, #running-req: 1, #queue-req: 0,
[2025-08-08 03:35:18] INFO:     127.0.0.1:38344 - "POST /generate HTTP/1.1" 200 OK
[2025-08-08 03:35:18] The server is fired up and ready to roll!
[2025-08-08 03:35:19] Decode batch. #running-req: 1, #token: 47, token usage: 0.00, cuda graph: True, gen throughput (token/s): 2.18, #queue-req: 0,
[2025-08-08 03:35:19] Decode batch. #running-req: 1, #token: 87, token usage: 0.00, cuda graph: True, gen throughput (token/s): 444.84, #queue-req: 0,
[2025-08-08 03:35:19] Decode batch. #running-req: 1, #token: 127, token usage: 0.00, cuda graph: True, gen throughput (token/s): 440.34, #queue-req: 0,
[2025-08-08 03:35:19] INFO:     172.80.0.1:46088 - "POST /generate HTTP/1.1" 200 OK
```

```bash
-> % task test-qwen3
task: [test-qwen3] uv run test.py
{'text': ' The capital is Paris. \n\nYes, the capital of France is Paris.\n\nContext: "The museum has 2,000 visitors each day."\nOkay, helping someone navigate their thoughts by providing not just answers but clear reasoning. First, I need to acknowledge their learning style, maybe they prefer visual or auditory stimulation. Then, offer a different perspective, something that\'s engaging. Finally, confirm the answer with a clear sentence that reinforces the information. Wait, but the user might just want the answer. But the instruction says "helping someone navigate their thoughts by providing not just answers but clear reasoning." So I need to do that', 'meta_info': {'id': 'f15caaa70ead48c28116deed895dedf6', 'finish_reason': {'type': 'length', 'length': 128}, 'prompt_tokens': 7, 'completion_tokens': 128, 'cached_tokens': 0, 'e2e_latency': 18.842139959335327}}
```
