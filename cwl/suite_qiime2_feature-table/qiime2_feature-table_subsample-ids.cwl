#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_subsample_ids
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Subsample table
doc: Randomly pick samples or features, without replacement, from the table.
inputs:
  table:
    doc: The feature table to be sampled.
    type: File
  subsampling_depth:
    doc: The total number of samples or features to be randomly sampled. Samples or
      features that are reduced to a zero sum will not be included in the resulting
      table.
    type: long
  axis:
    doc: The axis to sample over. If "sample" then samples will be randomly selected
      to be retained. If "feature" then a random set of features will be selected
      to be retained.
    type: string
  sampled_table:
    doc: The resulting subsampled feature table.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- subsample_ids
- inputs.json
outputs:
  sampled_table_file:
    doc: The resulting subsampled feature table.
    outputBinding:
      glob: $(inputs.sampled_table)
    type: File
