#!/bin/bash

#################################
# Get fastq files
#################################

# defining sample names and paths to data
declare -A get_samples=( ["ORANG"]="PONGO1 PONGO2" ["GOR"]="SN180 SN223")
declare -A get_paths=( ["GOR"]="/home/astridkd/testis_singlecell/backup/PrimaryData/gorilla/" ["ORANG"]="/home/astridkd/testis_singlecell/backup/PrimaryData/orangutan/")

# create paths in my own project folder, birc-project-akd/mapping, to fastq files located in PrimaryData
for sp in GOR ORANG
do
        for sample in ${get_samples[${sp}]}
        do
		
		mkdir -p ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}
		find ${get_paths[${sp}]}${sample}/* -name "*fastq.gz"|grep "R1"|sort > ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/path_to_fastq_R1.tsv
		find ${get_paths[${sp}]}${sample}/* -name "*fastq.gz"|grep "R2"|sort > ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/path_to_fastq_R2.tsv
        done
done
