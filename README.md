
# Running Griffin on duet and illumina data to compare results

## Set up

For analysis of our illumina and duet samples using Griffin I have used input files from Griffin paper analyses, and the ITSFASTR pipeline. We need to clone those repos:

```bash
git clone git@github.com:mouliere-lab/ITSFASTR.git
git clone git@github.com:adoebley/Griffin_analyses.git
```

## Data

Here we will use data previously used to assess fragmentomics comparability between duet and illumina WGS (DS-417).


```bash
bash bin/get_data.sh
```

You will need to have the reference genome in place to run the pipeline, in the current 
config files I have specified its location as `/scratch/reference/GRCh38Decoy.fa`, it must 
also be fai indexed using samtools.

Create sample sheets:

```bash
bash bin/create_samples.sh data/duet duet_samples.yaml
mv duet_samples.yaml snakemakes/griffin_GC_and_mappability_correction/config/
bash bin/create_samples.sh data/illumina ilm_samples.yaml
mv ilm_samples.yaml snakemakes/griffin_GC_and_mappability_correction/config/
```


## Griffin steps

```bash
conda env create -n griffin -f envs/griffin.yaml
conda activate griffin
```

Different config files are required to run Griffin in normal mode or long-read mode, which requires 
using the modified profiling script from ITSFASTR. Long read mode is used for duet in order to use the read length as the fragment length.


```bash
for seq in "duet" "ilm"; do
    mkdir -p "results_${seq}"
    
    cd snakemakes/griffin_GC_and_mappability_correction/

    snakemake \
      -s griffin_GC_and_mappability_correction.snakefile \
      -j 2 \
      --configfile "../../config_${seq}.yaml" \
      --configfile "../../${seq}_samples.yaml"
    cp "results/samples.GC.yaml" ../../snakemake/griffin_nucelosome_profiling/
    mv results/* "../../results_${seq}"
    
    cd ../../griffin_nucleosome_profiling
    
    snakemake \
      -s griffin_nucelosome_profiling.snakefile -j 2 \
      --configfile "../../config_${seq}.yaml" \
      --configfile "../../${seq}_samples.yaml"
    
    mv results/* "../../results_${seq}"
```


## Analysis

Analysis of outputs was performed in CA-802.