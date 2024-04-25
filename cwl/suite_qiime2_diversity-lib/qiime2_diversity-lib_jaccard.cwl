#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_lib_jaccard
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Jaccard Distance
doc: Compute Jaccard distance for each sample in a feature table. Jaccard is calculated
  usingpresence/absence data. Data of type FeatureTable[Frequency | Relative Frequency]
  is reducedto presence/absence prior to calculation.
inputs:
  table:
    doc: The feature table containing the samples for which Jaccard distance should
      be computed.
    type: File
  n_jobs:
    default: 1
    doc: The number of concurrent jobs to use in performing this calculation. May
      not exceed the number of available physical cores. If n_jobs = 'auto', one job
      will be launched for each identified CPU core on the host.
    type: long
  distance_matrix:
    doc: Distance matrix for Jaccard index
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity_lib
- jaccard
- inputs.json
outputs:
  distance_matrix_file:
    doc: Distance matrix for Jaccard index
    outputBinding:
      glob: $(inputs.distance_matrix)
    type: File
