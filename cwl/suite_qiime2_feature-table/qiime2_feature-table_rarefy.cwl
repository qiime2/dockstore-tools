#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_rarefy
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Rarefy table
doc: Subsample frequencies from all samples so that the sum of frequencies in each
  sample is equal to sampling-depth.
inputs:
  table:
    doc: The feature table to be rarefied.
    type: File
  sampling_depth:
    doc: The total frequency that each sample should be rarefied to. Samples where
      the sum of frequencies is less than the sampling depth will be not be included
      in the resulting table.
    type: long
  with_replacement:
    default: false
    doc: Rarefy with replacement by sampling from the multinomial distribution instead
      of rarefying without replacement.
    type: boolean
  rarefied_table:
    doc: The resulting rarefied feature table.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- rarefy
- inputs.json
outputs:
  rarefied_table_file:
    doc: The resulting rarefied feature table.
    outputBinding:
      glob: $(inputs.rarefied_table)
    type: File
