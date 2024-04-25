#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_merge_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Combine collections of feature sequences
doc: Combines feature data objects which may or may not contain data for the same
  features. If different feature data is present for the same feature id in the inputs,
  the data from the first will be propagated to the result.
inputs:
  data:
    doc: The collection of feature sequences to be merged.
    type: File[]
  merged_data:
    doc: The resulting collection of feature sequences containing all feature sequences
      provided.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- merge_seqs
- inputs.json
outputs:
  merged_data_file:
    doc: The resulting collection of feature sequences containing all feature sequences
      provided.
    outputBinding:
      glob: $(inputs.merged_data)
    type: File
