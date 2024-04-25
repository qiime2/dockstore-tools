#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_lib_bray_curtis
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Bray-Curtis Dissimilarity
doc: 'Compute Bray-Curtis dissimilarity for each sample in a feature table. Note:
  Frequency and relative frequency data produce different results unless overall sample
  sizes are identical. Please consider the impact on your results if you use Bray-Curtis
  with count data that has not been adjusted (normalized).'
inputs:
  table:
    doc: The feature table containing the samples for which Bray-Curtis dissimilarity
      should be computed.
    type: File
  n_jobs:
    default: 1
    doc: The number of concurrent jobs to use in performing this calculation. May
      not exceed the number of available physical cores. If n_jobs = 'auto', one job
      will be launched for each identified CPU core on the host.
    type: long
  distance_matrix:
    doc: Distance matrix for Bray-Curtis dissimilarity
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity_lib
- bray_curtis
- inputs.json
outputs:
  distance_matrix_file:
    doc: Distance matrix for Bray-Curtis dissimilarity
    outputBinding:
      glob: $(inputs.distance_matrix)
    type: File
