
####################################### Run HgtSIM #######################################

# run HgtSIM with different mutation levels (0, 5, 10, 15, 20, 25, 30)
python3 HgtSIM.py -t sequences_of_gene_transfers.fasta -i 0 -d distribution_of_transfers.txt -f selected_10_Betaproteobacteria -r 1-0-1-1 -x fna -lf TAGATGAGTGATTAGTTAGTTA -rf TAGATGAGTGATTAGTTAGTTA
python3 HgtSIM.py -t sequences_of_gene_transfers.fasta -i 5 -d distribution_of_transfers.txt -f selected_10_Betaproteobacteria -r 1-0-1-1 -x fna -lf TAGATGAGTGATTAGTTAGTTA -rf TAGATGAGTGATTAGTTAGTTA
python3 HgtSIM.py -t sequences_of_gene_transfers.fasta -i 10 -d distribution_of_transfers.txt -f selected_10_Betaproteobacteria -r 1-0-1-1 -x fna -lf TAGATGAGTGATTAGTTAGTTA -rf TAGATGAGTGATTAGTTAGTTA
python3 HgtSIM.py -t sequences_of_gene_transfers.fasta -i 15 -d distribution_of_transfers.txt -f selected_10_Betaproteobacteria -r 1-0-1-1 -x fna -lf TAGATGAGTGATTAGTTAGTTA -rf TAGATGAGTGATTAGTTAGTTA
python3 HgtSIM.py -t sequences_of_gene_transfers.fasta -i 20 -d distribution_of_transfers.txt -f selected_10_Betaproteobacteria -r 1-0-1-1 -x fna -lf TAGATGAGTGATTAGTTAGTTA -rf TAGATGAGTGATTAGTTAGTTA
python3 HgtSIM.py -t sequences_of_gene_transfers.fasta -i 25 -d distribution_of_transfers.txt -f selected_10_Betaproteobacteria -r 1-0-1-1 -x fna -lf TAGATGAGTGATTAGTTAGTTA -rf TAGATGAGTGATTAGTTAGTTA
python3 HgtSIM.py -t sequences_of_gene_transfers.fasta -i 30 -d distribution_of_transfers.txt -f selected_10_Betaproteobacteria -r 1-0-1-1 -x fna -lf TAGATGAGTGATTAGTTAGTTA -rf TAGATGAGTGATTAGTTAGTTA


################# Prepare input files for sequencing reads simulation ####################

# input_genomes_m0
cp HgtSIM_working_directory/selected_10_Alphaproteobacteria/*.fna input_files_for_simulation/input_genomes_m0
cp HgtSIM_working_directory/selected_10_Betaproteobacteria/*.fna input_files_for_simulation/input_genomes_m0

#i nput_genomes_m5
cp HgtSIM_working_directory/selected_10_Alphaproteobacteria/*.fna input_files_for_simulation/input_genomes_m5
cp HgtSIM_working_directory/outputs_5_1-0-1-1/Genomes_with_transfers/*.fna input_files_for_simulation/input_genomes_m5

# input_genomes_m10
cp HgtSIM_working_directory/selected_10_Alphaproteobacteria/*.fna input_files_for_simulation/input_genomes_m10
cp HgtSIM_working_directory/outputs_10_1-0-1-1/Genomes_with_transfers/*.fna input_files_for_simulation/input_genomes_m10

# input_genomes_m15
cp HgtSIM_working_directory/selected_10_Alphaproteobacteria/*.fna input_files_for_simulation/input_genomes_m15
cp HgtSIM_working_directory/outputs_15_1-0-1-1/Genomes_with_transfers/*.fna input_files_for_simulation/input_genomes_m15

# input_genomes_m20
cp HgtSIM_working_directory/selected_10_Alphaproteobacteria/*.fna input_files_for_simulation/input_genomes_m20
cp HgtSIM_working_directory/outputs_20_1-0-1-1/Genomes_with_transfers/*.fna input_files_for_simulation/input_genomes_m20

# input_genomes_m25
cp HgtSIM_working_directory/selected_10_Alphaproteobacteria/*.fna input_files_for_simulation/input_genomes_m25
cp HgtSIM_working_directory/outputs_25_1-0-1-1/Genomes_with_transfers/*.fna input_files_for_simulation/input_genomes_m25

# input_genomes_m30
cp HgtSIM_working_directory/selected_10_Alphaproteobacteria/*.fna input_files_for_simulation/input_genomes_m30
cp HgtSIM_working_directory/outputs_30_1-0-1-1/Genomes_with_transfers/*.fna input_files_for_simulation/input_genomes_m30

# combined_20_genomes_m0.fna 
cat input_files_for_simulation/input_genomes_m0/*.fna > Section3.2/combined_20_genomes_m0.fna


#################################### For Section 3.2 #####################################

# 3.2.1 reads simulation
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 10000000 -l 100 -i 250 -o l100i250
python3 Reads_simulator.py -R input_genomes_m5 -a abundance.txt -n 10000000 -l 100 -i 250 -o l100i250
python3 Reads_simulator.py -R input_genomes_m10 -a abundance.txt -n 10000000 -l 100 -i 250 -o l100i250
python3 Reads_simulator.py -R input_genomes_m15 -a abundance.txt -n 10000000 -l 100 -i 250 -o l100i250
python3 Reads_simulator.py -R input_genomes_m20 -a abundance.txt -n 10000000 -l 100 -i 250 -o l100i250
python3 Reads_simulator.py -R input_genomes_m25 -a abundance.txt -n 10000000 -l 100 -i 250 -o l100i250
python3 Reads_simulator.py -R input_genomes_m30 -a abundance.txt -n 10000000 -l 100 -i 250 -o l100i250

# 3.2.2 Assemble with IDBA_UD and metaSPAdes
module load idba/1.1.1_512
module load spades/3.9.0
# m0
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250.fasta --out combined_reads_m0_l100i250_k20-124
idba_ud --num_threads 14 --mink 20 --maxk 50 --step 10 --read combined_reads_m0_l100i250.fasta --out combined_reads_m0_l100i250_k20-50
idba_ud --num_threads 14 --mink 40 --maxk 70 --step 10 --read combined_reads_m0_l100i250.fasta --out combined_reads_m0_l100i250_k40-70
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250.fasta -o combined_reads_m0_l100i250_default
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250.fasta -o combined_reads_m0_l100i250_k21-125 -k 21,41,61,81,101,125
# m5
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m5_l100i250.fasta --out combined_reads_m5_l100i250_k20-124
idba_ud --num_threads 14 --mink 20 --maxk 50 --step 10 --read combined_reads_m5_l100i250.fasta --out combined_reads_m5_l100i250_k20-50
idba_ud --num_threads 14 --mink 40 --maxk 70 --step 10 --read combined_reads_m5_l100i250.fasta --out combined_reads_m5_l100i250_k40-70
spades.py --meta --only-assembler --12 combined_reads_m5_l100i250.fasta -o combined_reads_m5_l100i250_default
spades.py --meta --only-assembler --12 combined_reads_m5_l100i250.fasta -o combined_reads_m5_l100i250_k21-125 -k 21,41,61,81,101,125
# m10
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m10_l100i250.fasta --out combined_reads_m10_l100i250_k20-124
idba_ud --num_threads 14 --mink 20 --maxk 50 --step 10 --read combined_reads_m10_l100i250.fasta --out combined_reads_m10_l100i250_k20-50
idba_ud --num_threads 14 --mink 40 --maxk 70 --step 10 --read combined_reads_m10_l100i250.fasta --out combined_reads_m10_l100i250_k40-70
spades.py --meta --only-assembler --12 combined_reads_m10_l100i250.fasta -o combined_reads_m10_l100i250_default
spades.py --meta --only-assembler --12 combined_reads_m10_l100i250.fasta -o combined_reads_m10_l100i250_k21-125 -k 21,41,61,81,101,125
# m15
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m15_l100i250.fasta --out combined_reads_m15_l100i250_k20-124
idba_ud --num_threads 14 --mink 20 --maxk 50 --step 10 --read combined_reads_m15_l100i250.fasta --out combined_reads_m15_l100i250_k20-50
idba_ud --num_threads 14 --mink 40 --maxk 70 --step 10 --read combined_reads_m15_l100i250.fasta --out combined_reads_m15_l100i250_k40-70
spades.py --meta --only-assembler --12 combined_reads_m15_l100i250.fasta -o combined_reads_m15_l100i250_default
spades.py --meta --only-assembler --12 combined_reads_m15_l100i250.fasta -o combined_reads_m15_l100i250_k21-125 -k 21,41,61,81,101,125
# m20
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m20_l100i250.fasta --out combined_reads_m20_l100i250_k20-124
idba_ud --num_threads 14 --mink 20 --maxk 50 --step 10 --read combined_reads_m20_l100i250.fasta --out combined_reads_m20_l100i250_k20-50
idba_ud --num_threads 14 --mink 40 --maxk 70 --step 10 --read combined_reads_m20_l100i250.fasta --out combined_reads_m20_l100i250_k40-70
spades.py --meta --only-assembler --12 combined_reads_m20_l100i250.fasta -o combined_reads_m20_l100i250_default
spades.py --meta --only-assembler --12 combined_reads_m20_l100i250.fasta -o combined_reads_m20_l100i250_k21-125 -k 21,41,61,81,101,125
# m25
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m25_l100i250.fasta --out combined_reads_m25_l100i250_k20-124
idba_ud --num_threads 14 --mink 20 --maxk 50 --step 10 --read combined_reads_m25_l100i250.fasta --out combined_reads_m25_l100i250_k20-50
idba_ud --num_threads 14 --mink 40 --maxk 70 --step 10 --read combined_reads_m25_l100i250.fasta --out combined_reads_m25_l100i250_k40-70
spades.py --meta --only-assembler --12 combined_reads_m25_l100i250.fasta -o combined_reads_m25_l100i250_default
spades.py --meta --only-assembler --12 combined_reads_m25_l100i250.fasta -o combined_reads_m25_l100i250_k21-125 -k 21,41,61,81,101,125
# m30
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m30_l100i250.fasta --out combined_reads_m30_l100i250_k20-124
idba_ud --num_threads 14 --mink 20 --maxk 50 --step 10 --read combined_reads_m30_l100i250.fasta --out combined_reads_m30_l100i250_k20-50
idba_ud --num_threads 14 --mink 40 --maxk 70 --step 10 --read combined_reads_m30_l100i250.fasta --out combined_reads_m30_l100i250_k40-70
spades.py --meta --only-assembler --12 combined_reads_m30_l100i250.fasta -o combined_reads_m30_l100i250_default
spades.py --meta --only-assembler --12 combined_reads_m30_l100i250.fasta -o combined_reads_m30_l100i250_k21-125 -k 21,41,61,81,101,125
	
# 3.2.3 get recovered genes transfers
module load python/3.5.2
module load blast+/2.2.31
# m0
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_k20-124_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_k20-50_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_k40-70_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaSPAdes_m0_l100i250_default_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaSPAdes_m0_l100i250_k21-125_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
# m5
python3 Assembler_recovered_transfers.py -a IDBA_UD_m5_l100i250_k20-124_contig.fa -t input_sequence_mutant_nc_m5.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m5_l100i250_k20-50_contig.fa -t input_sequence_mutant_nc_m5.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m5_l100i250_k40-70_contig.fa -t input_sequence_mutant_nc_m5.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m5_l100i250_default_contigs.fasta -t input_sequence_mutant_nc_m5.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m5_l100i250_k21-125_contigs.fasta -t input_sequence_mutant_nc_m5.fasta -minf 1000
# m10
python3 Assembler_recovered_transfers.py -a IDBA_UD_m10_l100i250_k20-124_contig.fa -t input_sequence_mutant_nc_m10.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m10_l100i250_k20-50_contig.fa -t input_sequence_mutant_nc_m10.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m10_l100i250_k40-70_contig.fa -t input_sequence_mutant_nc_m10.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m10_l100i250_default_contigs.fasta -t input_sequence_mutant_nc_m10.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m10_l100i250_k21-125_contigs.fasta -t input_sequence_mutant_nc_m10.fasta -minf 1000
# m15
python3 Assembler_recovered_transfers.py -a IDBA_UD_m15_l100i250_k20-124_contig.fa -t input_sequence_mutant_nc_m15.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m15_l100i250_k20-50_contig.fa -t input_sequence_mutant_nc_m15.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m15_l100i250_k40-70_contig.fa -t input_sequence_mutant_nc_m15.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m15_l100i250_default_contigs.fasta -t input_sequence_mutant_nc_m15.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m15_l100i250_k21-125_contigs.fasta -t input_sequence_mutant_nc_m15.fasta -minf 1000
# m20
python3 Assembler_recovered_transfers.py -a IDBA_UD_m20_l100i250_k20-124_contig.fa -t input_sequence_mutant_nc_m20.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m20_l100i250_k20-50_contig.fa -t input_sequence_mutant_nc_m20.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m20_l100i250_k40-70_contig.fa -t input_sequence_mutant_nc_m20.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m20_l100i250_default_contigs.fasta -t input_sequence_mutant_nc_m20.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m20_l100i250_k21-125_contigs.fasta -t input_sequence_mutant_nc_m20.fasta -minf 1000
# m25
python3 Assembler_recovered_transfers.py -a IDBA_UD_m25_l100i250_k20-124_contig.fa -t input_sequence_mutant_nc_m25.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m25_l100i250_k20-50_contig.fa -t input_sequence_mutant_nc_m25.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m25_l100i250_k40-70_contig.fa -t input_sequence_mutant_nc_m25.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m25_l100i250_default_contigs.fasta -t input_sequence_mutant_nc_m25.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m25_l100i250_k21-125_contigs.fasta -t input_sequence_mutant_nc_m25.fasta -minf 1000
# m30
python3 Assembler_recovered_transfers.py -a IDBA_UD_m30_l100i250_k20-124_contig.fa -t input_sequence_mutant_nc_m30.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m30_l100i250_k20-50_contig.fa -t input_sequence_mutant_nc_m30.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a IDBA_UD_m30_l100i250_k40-70_contig.fa -t input_sequence_mutant_nc_m30.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m30_l100i250_default_contigs.fasta -t input_sequence_mutant_nc_m30.fasta -minf 1000
python3 Assembler_recovered_transfers.py -a metaSPAdes_m30_l100i250_k21-125_contigs.fasta -t input_sequence_mutant_nc_m30.fasta -minf 1000


###################################### Section 3.3 #######################################

# 3.3.1 simulate reads with different depth
module load python/3.5.2
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 1000000 -l 100 -i 250 -o l100i250_1_million
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 1500000 -l 100 -i 250 -o l100i250_1.5_million
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 2000000 -l 100 -i 250 -o l100i250_2_million
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 2500000 -l 100 -i 250 -o l100i250_2.5_million
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 3000000 -l 100 -i 250 -o l100i250_3_million
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 5000000 -l 100 -i 250 -o l100i250_5_million
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 10000000 -l 100 -i 250 -o l100i250_10_million #(from Section 3.2)
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 20000000 -l 100 -i 250 -o l100i250_20_million

# 3.3.2 Assemble with IDBA_UD and metaSPAdes			
# IDBA_UD			
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250_1_million.fasta --out IDBA_UD_m0_l100i250_1_million
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250_1.5_million.fasta --out IDBA_UD_m0_l100i250_1.5_million
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250_2_million.fasta --out IDBA_UD_m0_l100i250_2_million
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250_2.5_million.fasta --out IDBA_UD_m0_l100i250_2.5_million
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250_3_million.fasta --out IDBA_UD_m0_l100i250_3_million
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250_5_million.fasta --out IDBA_UD_m0_l100i250_5_million
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250_10_million.fasta --out IDBA_UD_m0_l100i250_10_million
idba_ud --num_threads 14 --mink 20 --maxk 124 --step 20 --read combined_reads_m0_l100i250_20_million.fasta --out IDBA_UD_m0_l100i250_20_million
# metaSPAdes_k21-55
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_1_million.fasta -o metaspade_m0_k21-55_l100i250_1_million
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_1.5_million.fasta -o metaspade_m0_k21-55_l100i250_1.5_million
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_2_million.fasta -o metaspade_m0_k21-55_l100i250_2_million
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_2.5_million.fasta -o metaspade_m0_k21-55_l100i250_2.5_million
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_3_million.fasta -o metaspade_m0_k21-55_l100i250_3_million
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_5_million.fasta -o metaspade_m0_k21-55_l100i250_5_million
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_10_million.fasta -o metaspade_m0_k21-55_l100i250_10_million
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_20_million.fasta -o metaspade_m0_k21-55_l100i250_20_million
# metaSPAdes_k21-125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_1_million.fasta -o metaspade_m0_k21-125_l100i250_1_million -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_1.5_million.fasta -o metaspade_m0_k21-125_l100i250_1.5_million -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_2_million.fasta -o metaspade_m0_k21-125_l100i250_2_million -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_2.5_million.fasta -o metaspade_m0_k21-125_l100i250_2.5_million -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_3_million.fasta -o metaspade_m0_k21-125_l100i250_3_million -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_5_million.fasta -o metaspade_m0_k21-125_l100i250_5_million -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_10_million.fasta -o metaspade_m0_k21-125_l100i250_10_million -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250_20_million.fasta -o metaspade_m0_k21-125_l100i250_20_million -k 21,41,61,81,101,125
		
# Assess the quality of assemblies with metaQUAST  
module load python/2.7.12
module load perl/5.20.1
module load java/8u91
module load quast/4.5
# IDBA_UD
metaquast.py -R input_genomes_m0 -o IDBA_UD_m0_l100i250_1.5_million_contig IDBA_UD_m0_l100i250_1.5_million_contig.fa         
metaquast.py -R input_genomes_m0 -o IDBA_UD_m0_l100i250_10_million_contig IDBA_UD_m0_l100i250_10_million_contig.fa         
metaquast.py -R input_genomes_m0 -o IDBA_UD_m0_l100i250_1_million_contig IDBA_UD_m0_l100i250_1_million_contig.fa         
metaquast.py -R input_genomes_m0 -o IDBA_UD_m0_l100i250_2.5_million_contig IDBA_UD_m0_l100i250_2.5_million_contig.fa         
metaquast.py -R input_genomes_m0 -o IDBA_UD_m0_l100i250_20_million_contig IDBA_UD_m0_l100i250_20_million_contig.fa         
metaquast.py -R input_genomes_m0 -o IDBA_UD_m0_l100i250_2_million_contig IDBA_UD_m0_l100i250_2_million_contig.fa         
metaquast.py -R input_genomes_m0 -o IDBA_UD_m0_l100i250_3_million_contig IDBA_UD_m0_l100i250_3_million_contig.fa         
metaquast.py -R input_genomes_m0 -o IDBA_UD_m0_l100i250_5_million_contig IDBA_UD_m0_l100i250_5_million_contig.fa
# metaSPAdes_k21-55         
metaquast.py -R input_genomes_m0 -o metaspade_m0_default_l100i250_1.5_million metaspade_m0_default_l100i250_1.5_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_default_l100i250_10_million metaspade_m0_default_l100i250_10_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_default_l100i250_1_million metaspade_m0_default_l100i250_1_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_default_l100i250_2.5_million metaspade_m0_default_l100i250_2.5_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_default_l100i250_20_million metaspade_m0_default_l100i250_20_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_default_l100i250_2_million metaspade_m0_default_l100i250_2_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_default_l100i250_3_million metaspade_m0_default_l100i250_3_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_default_l100i250_5_million metaspade_m0_default_l100i250_5_million.fasta         
# metaSPAdes_k21-125
metaquast.py -R input_genomes_m0 -o metaspade_m0_k21-125_l100i250_1.5_million metaspade_m0_k21-125_l100i250_1.5_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_k21-125_l100i250_10_million metaspade_m0_k21-125_l100i250_10_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_k21-125_l100i250_1_million metaspade_m0_k21-125_l100i250_1_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_k21-125_l100i250_2.5_million metaspade_m0_k21-125_l100i250_2.5_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_k21-125_l100i250_20_million metaspade_m0_k21-125_l100i250_20_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_k21-125_l100i250_2_million metaspade_m0_k21-125_l100i250_2_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_k21-125_l100i250_3_million metaspade_m0_k21-125_l100i250_3_million.fasta         
metaquast.py -R input_genomes_m0 -o metaspade_m0_k21-125_l100i250_5_million metaspade_m0_k21-125_l100i250_5_million.fasta         

# 3.3.3 get recovered gene transfers
module load python/3.5.2
module load blast+/2.2.31		
# IDBA_UD assemblies
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_1_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_1.5_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_2_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_2.5_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_3_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_5_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_10_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a IDBA_UD_m0_l100i250_20_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
# metaSPAdes_k21-55 assemblies
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-55_l100i250_1_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-55_l100i250_1.5_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-55_l100i250_2_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-55_l100i250_2.5_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-55_l100i250_3_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-55_l100i250_5_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-55_l100i250_10_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-55_l100i250_20_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
# metaSPAdes_k21-125 assemblies						
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-125_l100i250_1_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-125_l100i250_1.5_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-125_l100i250_2_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-125_l100i250_2.5_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-125_l100i250_3_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-125_l100i250_5_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-125_l100i250_10_million_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaspade_m0_k21-125_l100i250_20_million_contigs.fasta	 -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna


###################################### Section 3.4 #######################################

# 3.4.1 reads simulation
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 3000000 -l 100 -i 250 -o m0_l100i250
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 3000000 -l 100 -i 500 -o m0_l100i500
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 3000000 -l 100 -i 1000 -o m0_l100i1000
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 1200000 -l 250 -i 250 -o m0_l250i250
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 1200000 -l 250 -i 500 -o m0_l250i500
python3 Reads_simulator.py -R input_genomes_m0 -a abundance.txt -n 1200000 -l 250 -i 1000 -o m0_l250i1000

# 3.4.2 Assemble with metaSPAdes_k21-125
module load spades/3.9.0
spades.py --meta --only-assembler --12 combined_reads_m0_l100i1000.fasta -o metaSPAdes_k21-125_m0_l100i1000 -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i250.fasta -o metaSPAdes_k21-125_m0_l100i250 -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l100i500.fasta -o metaSPAdes_k21-125_m0_l100i500 -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l250i1000.fasta -o metaSPAdes_k21-125_m0_l250i1000 -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l250i250.fasta -o metaSPAdes_k21-125_m0_l250i250 -k 21,41,61,81,101,125
spades.py --meta --only-assembler --12 combined_reads_m0_l250i500.fasta -o metaSPAdes_k21-125_m0_l250i500 -k 21,41,61,81,101,125

# 3.4.3 get recovered gene transfers
python3 Assembler_recovered_transfers_iden100.py -a metaSPAdes_k21-125_m0_l100i1000_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaSPAdes_k21-125_m0_l100i250_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaSPAdes_k21-125_m0_l100i500_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaSPAdes_k21-125_m0_l250i1000_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaSPAdes_k21-125_m0_l250i250_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna
python3 Assembler_recovered_transfers_iden100.py -a metaSPAdes_k21-125_m0_l250i500_contigs.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna


###################################### Section 3.5 #######################################

module load python/3.5.2
module load blast+/2.2.31		
# IDBA_UD_k20-124_2_million		
python3 Assembler_recovered_transfers_iden100_length_correlation.py -a IDBA_UD_m0_l100i250_2_million_contig.fa -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna 
# metaSPAdes_k21-55_1.5_million		
python3 Assembler_recovered_transfers_iden100_length_correlation.py -a metaspade_m0_default_l100i250_1.5_million.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna 
# metaSPAdes_k21-125_3_million		
python3 Assembler_recovered_transfers_iden100_length_correlation.py -a metaspade_m0_k21-125_l100i250_3_million.fasta -t input_sequence_mutant_nc_m0.fasta -minf 1000 -d distribution_of_transfers.txt -combined_genomes combined_20_genomes_m0.fna 			
