#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_filter_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter features from sequences
doc: Filter features from sequences based on a feature table or metadata. See the
  filtering tutorial on https://docs.qiime2.org for additional details. This method
  can filter based on ids in a table or a metadata file, but not both (i.e., the table
  and metadata options are mutually exclusive).
inputs:
  data:
    doc: The sequences from which features should be filtered.
    type: File
  table:
    doc: Table containing feature ids used for id-based filtering.
    type: File?
  q2cwl_metafile_metadata:
    doc: Feature metadata used for id-based filtering, with `where` parameter when
      selecting features to retain, or with `exclude_ids` when selecting features
      to discard.
    type:
    - File?
    - File[]?
  where:
    doc: SQLite WHERE clause specifying feature metadata criteria that must be met
      to be included in the filtered feature table. If not provided, all features
      in `metadata` that are also in the sequences will be retained.
    type: string?
  exclude_ids:
    default: false
    doc: If true, the features selected by the `metadata` (with or without the `where`
      parameter) or `table` parameter will be excluded from the filtered sequences
      instead of being retained.
    type: boolean
  filtered_data:
    doc: The resulting filtered sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- filter_seqs
- inputs.json
outputs:
  filtered_data_file:
    doc: The resulting filtered sequences.
    outputBinding:
      glob: $(inputs.filtered_data)
    type: File
