#!/bin/bash

#################################
# Get fastq files
#################################

# defining sample names and paths to data
declare -A get_samples=( ["GOR"]="MB_n_B4" ["HUM"]="SN142 SN111 SN052 SN011 SN007" ["CHIMP"]="Carl SN074 SN112 SN193" ["BON"]="SN219 SN224" ["MAC"]="SN116 SN143")
declare -A get_paths=( ["GOR"]="/home/astridkd/testis_singlecell/backup/PrimaryData/gorilla/" ["HUM"]="/home/astridkd/testis_singlecell/backup/PrimaryData/human/" ["CHIMP"]="/home/astridkd/testis_singlecell/backup/PrimaryData/chimpanzee/" ["BON"]="/home/astridkd/testis_singlecell/backup/PrimaryData/bonobo/" ["MAC"]="/home/astridkd/testis_singlecell/backup/PrimaryData/macaque/")

# create paths in my own project folder, birc-project-akd/mapping, to fastq files located in PrimaryData
for sp in HUM CHIMP BON MAC GOR
do
        for sample in ${get_samples[${sp}]}
        do
		
		mkdir -p ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}
		find ${get_paths[${sp}]}${sample}/* -name "*fastq.gz"|grep "R1"|sort > ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/path_to_fastq_R1.tsv
		find ${get_paths[${sp}]}${sample}/* -name "*fastq.gz"|grep "R2"|sort > ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/path_to_fastq_R2.tsv
        done
done
