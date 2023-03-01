######################################################################################
#A.SET ENVIRONMENT AND IMPORT SYS,OS
###################################################################################### 
from gwf import Workflow
import sys, os, re
import gzip
gwf = Workflow()

######################################################################################
#B.FUNCTIONS AND TEMPLATES
######################################################################################

def reference_starsolo(path_to_ref,genome_fa,gene_annotation): # creates human reference in my folder
	inputs = []
	outputs = [f'{path_to_ref}Log.out']
	options = {"memory": "50g","account":"testis_singlecell","walltime":"05:00:00"}
	spec='''

	cd {} 
	STAR  --runMode genomeGenerate --runThreadN 4 --genomeSAsparseD 3 --genomeDir {} --genomeFastaFiles {}  --sjdbGTFfile {}	

	'''.format(path_to_ref,path_to_ref,genome_fa,gene_annotation) 

	return inputs,outputs,options,spec

def mapping_starsolo_velocity(path_to_ref, read_2, read_1, CB_whitelist, out_prefix):
	inputs = [path_to_ref+'Log.out']
	outputs = [f'{out_prefix}Log.final.out']
	options = {"memory": "70g","walltime":"30:00:00", "account":"testis_singlecell"}
	spec='''

	cd {} 
	STAR --genomeDir {} --readFilesIn <(zcat {}) <(zcat {}) --clipAdapterType CellRanger4 --soloCellFilter EmptyDrops_CR --soloFeatures Gene GeneFull SJ Velocyto --soloMultiMappers Uniform PropUnique EM Rescue --outFilterScoreMin 30 --soloCBmatchWLtype 1MM_multi_Nbase_pseudocounts --soloUMIfiltering MultiGeneUMI_CR --soloUMIdedup 1MM_CR --soloType CB_UMI_Simple --soloCBwhitelist {} --soloBarcodeReadLength 0 --outSAMtype BAM Unsorted --outSAMattributes NH HI nM AS CR UR GX GN sS sQ sM --limitOutSJcollapsed 5000000

	'''.format(out_prefix, path_to_ref, read_2, read_1, CB_whitelist)

	return inputs,outputs,options,spec

######################################################################################
#D.CODE
###################################################################################### 

path_to_barcodes_v2 = "/home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/scripts/10X_barcodes/737K-august-2016.txt"
path_to_barcodes_v3 = "/home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/scripts/10X_barcodes/3M-february-2018.txt"

sp_name_dict = {
	"HUM":"human", "CHIMP":"chimpanzee", "BON":"bonobo", "MAC":"macaque", "GOR":"gorilla"
}


sp_sample_dict = {
	"HUM":["SN142","SN111","SN052","SN011","SN007"], "GOR":["MB_n_B4"], "CHIMP":["Carl", "SN074", "SN112", "SN193"], "BON":["SN219", "SN224"], "MAC":["SN116", "SN143"]
}


# Carl:v3 chamistry. path_to_barcodes_v3

in_path = f'/home/astridkd/testis_singlecell/backup/PrimaryData/human/ref'
out_path = f'/home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/'

# input files
genome_file = f'{in_path}/genome.fa'
gene_annotation_file = f'{in_path}/genes_amplicons_starsolo.gtf'

## STARsolo genome ref
		
path_to_ref = f'{out_path}annotation_starsolo/'

if not os.path.exists(path_to_ref):
	os.makedirs(path_to_ref)

gwf.target_from_template(f'starsolo_ref_annotation', # name of the target in log
	reference_starsolo(path_to_ref,genome_file,gene_annotation_file)) # template 

## Mapping

for sp,name in sp_name_dict.items():

	out_path = f'/home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping/{sp}/'
	
	matrix_counts = []
	velocyto_path = []
	samples = []
	
	for sample in sp_sample_dict[sp]:

		barcode_file = path_to_barcodes_v2
		
		out_path_sample = f'{out_path}{sample}/'
		
		fastq_files_R1 = open(f'{out_path_sample}path_to_fastq_R1.tsv').read().rstrip("\n").split("\n")
		fastq_files_R2 = open(f'{out_path_sample}path_to_fastq_R2.tsv').read().rstrip("\n").split("\n")
		# strip of end space and split the lines into lists
		
		gwf.target_from_template(f'run_starsolo_{sp}_{sample}', # name of the target
			mapping_starsolo_velocity(path_to_ref, " ".join(fastq_files_R2), " ".join(fastq_files_R1), barcode_file, out_path_sample))		
