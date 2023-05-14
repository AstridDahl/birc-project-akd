input_file = '/home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping_own_ref/MAC/annotation_starsolo/geneInfo.tab'
output_file = '/home/astridkd/testis_singlecell/Workspaces/adahl/birc-project-akd/data/mapping_own_ref/MAC/annotation_starsolo/MAC_lncRNAs.txt'

with open(input_file, 'r') as f, open(output_file, 'w') as out:
    for line in f:
        if 'lncRNA' in line:
            columns = line.strip().split('\t')
        # if 'lncRNA' in columns[2]:
            out.write(columns[0] + '\n')
        # for x in range(3):
        #     if columns[x]=="lncRNA":
        #         out.write(columns[x-2] + '\n')
f.close()
out.close()