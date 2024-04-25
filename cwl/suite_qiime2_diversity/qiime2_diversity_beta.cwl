#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_beta
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Beta diversity
doc: Computes a user-specified beta diversity metric for all pairs of samples in a
  feature table.
inputs:
  table:
    doc: The feature table containing the samples over which beta diversity should
      be computed.
    type: File
  metric:
    doc: The beta diversity metric to be computed.
    type: string
  pseudocount:
    default: 1
    doc: A pseudocount to handle zeros for compositional metrics.  This is ignored
      for other metrics.
    type: long
  n_jobs:
    default: 1
    doc: The number of concurrent jobs to use in performing this calculation. May
      not exceed the number of available physical cores. If n_jobs = 'auto', one job
      will be launched for each identified CPU core on the host.
    type: long
  distance_matrix:
    doc: The resulting distance matrix.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- beta
- inputs.json
outputs:
  distance_matrix_file:
    doc: The resulting distance matrix.
    outputBinding:
      glob: $(inputs.distance_matrix)
    type: File
