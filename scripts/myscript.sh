#!/bin/bash
#SBATCH --mem=1gb
#SBATCH --time=01:00:00
#SBATCH --account=testis_singlecell
#SBATCH --job-name=firstjob

echo "I can submit cluster jobs now!" > success.txt
