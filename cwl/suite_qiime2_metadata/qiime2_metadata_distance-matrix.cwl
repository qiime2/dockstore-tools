#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_metadata_distance_matrix
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Create a distance matrix from a numeric Metadata column
doc: 'Create a distance matrix from a numeric metadata column. The Euclidean distance
  is computed between each pair of samples or features in the column.


  Tip: the distance matrix produced by this method can be used as input to the Mantel
  test available in `q2-diversity`.'
inputs:
  q2cwl_metafile_metadata:
    doc: Numeric metadata column to compute pairwise Euclidean distances from
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  distance_matrix:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- metadata
- distance_matrix
- inputs.json
outputs:
  distance_matrix_file:
    doc: null
    outputBinding:
      glob: $(inputs.distance_matrix)
    type: File
