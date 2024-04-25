#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_merge
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Combine multiple tables
doc: Combines feature tables using the `overlap_method` provided.
inputs:
  tables:
    doc: The collection of feature tables to be merged.
    type: File[]
  overlap_method:
    default: error_on_overlapping_sample
    doc: Method for handling overlapping ids.
    type: string
  merged_table:
    doc: The resulting merged feature table.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- merge
- inputs.json
outputs:
  merged_table_file:
    doc: The resulting merged feature table.
    outputBinding:
      glob: $(inputs.merged_table)
    type: File
