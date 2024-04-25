#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_beta_group_significance
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Beta diversity group significance
doc: Determine whether groups of samples are significantly different from one another
  using a permutation-based statistical test.
inputs:
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    type: File
  q2cwl_metafile_metadata:
    doc: Categorical sample metadata column.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  method:
    default: permanova
    doc: The group significance test to be applied.
    type: string
  pairwise:
    default: false
    doc: Perform pairwise tests between all pairs of groups in addition to the test
      across all groups. This can be very slow if there are a lot of groups in the
      metadata column.
    type: boolean
  permutations:
    default: 999
    doc: The number of permutations to be run when computing p-values.
    type: long
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- beta_group_significance
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
