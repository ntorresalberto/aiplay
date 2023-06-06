#!/usr/bin/env bash

set -xe

pip3 install --upgrade pip
cd stable-diffusion
pip3 install -r ../requirements.txt

python3 optimizedSD/optimized_txt2img.py --prompt "A photograph of an astronaut riding a horse" --H 512 --W 512 --seed 1 --n_iter 2 --n_samples 1 --ddim_steps 50
