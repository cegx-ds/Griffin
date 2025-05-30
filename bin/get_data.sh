#!/bin/bash

mkdir -p data
mkdir -p data/duet
mkdir -p data/illumina

duet_samples=(
    "CEG1599-AM01-D1302-012"
    "CEG1599-EL01-D1278-009"
    "CEG1599-SY01-D977-005"
    "CEG1599-SY01-D977-007"
    "CEG1599-SY01-D977-009"
    "CEG1599-SY01-D977-012"
    "CEG1599-SY01-D977-014"
    "CEG1599-SY01-D977-015"
    "CEG1599-SY01-D977-016"
    "CEG1599-SY01-D977-017"
    "CEG1599-SY01-D977-018"
    "CEG1599-SY01-D978-006"
)

for sample in "${duet_samples[@]}"; do
    gsutil cp gs://cegx-runcrc/nf-results/duet-alpha-1.1.3a2_PE251_CRC_fragment_length_default_params_JWS_30-01-2024-1718_6bp/dedup_genome_bams/${sample}* data/duet/
done

ilm_samples=(
    "CEG1694-AM01-I1623-014"
    "CEG1694-AM01-I1623-008"
    "CEG1694-AM01-I1623-011"
    "CEG1694-AM01-I1623-016"
    "CEG1694-AM01-I1623-006"
    "CEG1694-AM01-I1623-005"
    "CEG1694-AM01-I1623-013"
    "CEG1694-AM01-I1623-015"
    "CEG1694-AM01-I1623-004"
    "CEG1694-AM01-I1623-009"
    "CEG1694-AM01-I1623-002"
    "CEG1694-AM01-I1623-010"
)

for sample in "${ilm_samples[@]}"; do
    gsutil cp gs://cegx-run1694/nf-results/illumina-alpha-0.0.1_WGS-CRC-seracare-cfDNA-PE250-jws-27-11-2023/dedup_genome_bams/${sample}* data/illumina/
done