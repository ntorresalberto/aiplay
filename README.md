# aiplay

### foreword

For unsuported cards you might need to override your GPU by setting this ENV varriable. In the RX 6700s case it’s needed because it’s not directly supported for but another card with same architecture is

```
export HSA_OVERRIDE_GFX_VERSION=10.3.0
rocm-smi --setperflevel high
```

### quickstart:

```bash
./tensor_docker.sh
./tensortest.py # simple print devices and train example
```

NOTE: `--H 256 --W 256 --n_samples=1` are necessary to avoid OOM VRAM problems
NOTE 2: modified to use vram-optimized version
NOTE 3: `requirements.txt` was manually constructed from stable-diffusion/environment.yaml

```bash
./torch_docker.sh
git clone https://github.com/basujindal/stable-diffusion.git
cd stable-diffusion/
pip install --upgrade pip
pip install -r ../requirements.txt
mkdir -pv models/ldm/stable-diffusion-v1/
wget https://huggingface.co/CompVis/stable-diffusion-v-1-4-original/resolve/main/sd-v1-4.ckpt
ln -vs $(pwd)/sd-v1-4.ckpt models/ldm/stable-diffusion-v1/model.ckpt
python3 optimizedSD/optimized_txt2img.py --prompt "A photograph of an astronaut riding a horse" --H 512 --W 512 --seed 1 --n_iter 2 --n_samples 1 --ddim_steps 50
```


### sources:

basic rocm setup: https://www.videogames.ai/2022/09/01/RX-6700s-Machine-Learning-ROCm.html

stable-diffusion: https://www.videogames.ai/2022/11/06/Stable-Diffusion-AMD-GPU-ROCm-Linux.html

fix diffusers dep: https://github.com/CompVis/stable-diffusion/issues/627

docker: https://towardsdatascience.com/train-neural-networks-using-amd-gpus-and-keras-37189c453878


### benchmarks

```bash
git clone https://github.com/tensorflow/benchmarks.git
cd benchmarks/scripts/tf_cnn_benchmarks # in docker it's /root/benchmarks/scripts/tf_cnn_benchmarks
python3 tf_cnn_benchmarks.py --num_gpus=1 --batch_size=32 --model=resnet50 # ~130 images/sec
python3 tf_cnn_benchmarks.py --num_gpus=1 --batch_size=32 --model=resnet50 --use_fp16 # ~173 images/sec
python3 tf_cnn_benchmarks.py --num_gpus=1 --batch_size=32 --model=alexnet # ~1000 images/sec
```
