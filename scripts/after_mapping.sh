#!/bin/bash

###############################
## MAPPING TO STARSOLO
###############################

declare -A get_samples=( ["GOR"]="MB_n_B4" ["HUM"]="SN142 SN111 SN052 SN011 SN007" ["CHIMP"]="Carl SN074 SN112 SN193" ["BON"]="SN219 SN224" ["MAC"]="SN116 SN143")
path="/home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/"

for sp in HUM CHIMP BON MAC GOR
do

        for sample in ${get_samples[${sp}]}
        do
                # compress files
                gzip /home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/GeneFull/filtered/matrix.mtx
                gzip /home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/GeneFull/filtered/features.tsv
                gzip /home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/GeneFull/filtered/barcodes.tsv
                # make unspliced folder
                mkdir -p /home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/Velocyto/raw/unspliced/
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/unspliced.mtx ${path}${sp}/${sample}/Solo.out/Velocyto/raw/unspliced/matrix.mtx
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/features.tsv ${path}${sp}/${sample}/Solo.out/Velocyto/raw/unspliced/
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/barcodes.tsv ${path}${sp}/${sample}/Solo.out/Velocyto/raw/unspliced/
                # make spliced folder
                mkdir -p ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/Velocyto/raw/spliced/
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/spliced.mtx ${path}${sp}/${sample}/Solo.out/Velocyto/raw/spliced/matrix.mtx
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/features.tsv ${path}${sp}/${sample}/Solo.out/Velocyto/raw/spliced/
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/barcodes.tsv ${path}${sp}/${sample}/Solo.out/Velocyto/raw/spliced/
                # make ambiguous folder
                mkdir -p ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/Velocyto/raw/ambiguous/
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/ambiguous.mtx ${path}${sp}/${sample}/Solo.out/Velocyto/raw/ambiguous/matrix.mtx
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/features.tsv ${path}${sp}/${sample}/Solo.out/Velocyto/raw/ambiguous/
                cp ${path}${sp}/${sample}/Solo.out/Velocyto/raw/barcodes.tsv ${path}${sp}/${sample}/Solo.out/Velocyto/raw/ambiguous/
                # compress all files in the new folders
                gzip /home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/Velocyto/raw/unspliced/*
                gzip /home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/Velocyto/raw/spliced/*
                gzip /home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/Velocyto/raw/ambiguous/*
                # make folder for files to scanpy
                mkdir -p ~/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/GeneFull/raw/to_scanpy/
                cp ${path}${sp}/${sample}/Solo.out/GeneFull/raw/UniqueAndMult-EM.mtx ${path}${sp}/${sample}/Solo.out/GeneFull/raw/to_scanpy/matrix.mtx
                cp ${path}${sp}/${sample}/Solo.out/GeneFull/raw/features.tsv ${path}${sp}/${sample}/Solo.out/GeneFull/raw/to_scanpy/
                cp ${path}${sp}/${sample}/Solo.out/GeneFull/raw/barcodes.tsv ${path}${sp}/${sample}/Solo.out/GeneFull/raw/to_scanpy/
                gzip /home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/${sp}/${sample}/Solo.out/GeneFull/raw/to_scanpy/*

        done
done


