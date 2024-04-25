#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_bioenv
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: bioenv
doc: Find the subsets of variables in metadata whose Euclidean distances are maximally
  rank-correlated with distance matrix. All numeric variables in metadata will be
  considered, and samples which are missing data will be dropped. The output visualization
  will indicate how many samples were dropped due to missing data, if any were dropped.
inputs:
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    type: File
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- bioenv
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
