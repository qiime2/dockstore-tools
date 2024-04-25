#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_split
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Split one feature table into many
doc: Splits one feature table into many feature tables, where splits are defined by
  values in metadata column.
inputs:
  table:
    doc: The table to split.
    type: File
  q2cwl_metafile_metadata:
    doc: A column defining the groups. Each unique value will define a split feature
      table.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  filter_empty_features:
    default: true
    doc: If true, features which are not present in a split feature table are dropped.
    type: boolean
  tables:
    doc: Directory where feature tables split based on metadata values should be written.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- split
- inputs.json
outputs:
  tables_dir:
    doc: Directory where feature tables split based on metadata values should be written.
    outputBinding:
      glob: $(inputs.tables)
    type: Directory
