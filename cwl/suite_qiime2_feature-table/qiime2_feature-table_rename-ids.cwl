#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_rename_ids
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Renames sample or feature ids in a table
doc: Renames the sample or feature ids in a feature table using metadata to define
  the new ids.
inputs:
  table:
    doc: The table to be renamed
    type: File
  q2cwl_metafile_metadata:
    doc: A metadata column defining the new ids. Each original id must map to a new
      unique id. If strict mode is used, then every id in the original table must
      have a new id.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  axis:
    default: sample
    doc: Along which axis to rename the ids.
    type: string
  strict:
    default: false
    doc: Whether the naming needs to be strict (each id in the table must have a new
      id). Otherwise, only the ids described in `metadata` will be renamed and the
      others will keep their original id names.
    type: boolean
  renamed_table:
    doc: A table which has new ids, where the ids are replaced by values in the `metadata`
      column.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- rename_ids
- inputs.json
outputs:
  renamed_table_file:
    doc: A table which has new ids, where the ids are replaced by values in the `metadata`
      column.
    outputBinding:
      glob: $(inputs.renamed_table)
    type: File
