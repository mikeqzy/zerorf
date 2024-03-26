#!/bin/bash

#SBATCH -n 8
#SBATCH -t 01-00
#SBATCH --mem-per-cpu=4096
#SBATCH --gpus=rtx_3090:1
#SBATCH --gres=gpumem:16G
#SBATCH --tmp=8G
#SBATCH -A es_tang
#SBATCH --output=logs/slurm-%j.out
#SBATCH --mail-type=FAIL

PROJ=$1
OBJ=$2
CONFIGS="${@:3}"

cd ..
export WANDB_API_KEY=$(cat "wandb.key")
module load eth_proxy gcc/6.3.0 cuda/11.6.2
#python -W ignore launch.py tag=${TAG} ${CONFIGS}
python -W ignore zerorf.py --proj-name=${PROJ} --rep=tensorf --obj=${OBJ} --n-views=6 --dataset=nerf_syn ${CONFIGS}
