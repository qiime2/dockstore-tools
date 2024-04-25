#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_transpose
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Transpose a feature table.
doc: Transpose the rows and columns (typically samples and features) of a feature
  table.
inputs:
  table:
    doc: The feature table to be transposed.
    type: File
  transposed_feature_table:
    doc: The resulting transposed feature table.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- transpose
- inputs.json
outputs:
  transposed_feature_table_file:
    doc: The resulting transposed feature table.
    outputBinding:
      glob: $(inputs.transposed_feature_table)
    type: File
