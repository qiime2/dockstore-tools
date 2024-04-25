#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_partial_procrustes
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Partial Procrustes
doc: Transform one ordination into another, using paired samples to anchor the transformation.
  This method allows does not require all samples to be paired.
inputs:
  reference:
    doc: The ordination matrix to which data is fitted to.
    type: File
  other:
    doc: The ordination matrix that's fitted to the reference ordination.
    type: File
  q2cwl_metafile_pairing:
    doc: The metadata column describing sample pairs which exist.
    type: File
  pairing:
    doc: Column name to use from 'pairing' file
    type: string
  dimensions:
    default: 5
    doc: The number of dimensions to use when fitting the two matrices
    type: long
  transformed:
    doc: The 'other' ordination transformed into the space of the reference ordination.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- partial_procrustes
- inputs.json
outputs:
  transformed_file:
    doc: The 'other' ordination transformed into the space of the reference ordination.
    outputBinding:
      glob: $(inputs.transformed)
    type: File
