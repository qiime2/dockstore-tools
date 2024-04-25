#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_group
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Group samples or features by a metadata column
doc: Group samples or features in a feature table using metadata to define the mapping
  of IDs to a group.
inputs:
  table:
    doc: The table to group samples or features on.
    type: File
  axis:
    doc: Along which axis to group. Each ID in the given axis must exist in `metadata`.
    type: string
  q2cwl_metafile_metadata:
    doc: A column defining the groups. Each unique value will become a new ID for
      the table on the given `axis`.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  mode:
    doc: How to combine samples or features within a group. `sum` will sum the frequencies
      across all samples or features within a group; `mean-ceiling` will take the
      ceiling of the mean of these frequencies; `median-ceiling` will take the ceiling
      of the median of these frequencies.
    type: string
  grouped_table:
    doc: A table that has been grouped along the given `axis`. IDs on that axis are
      replaced by values in the `metadata` column.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- group
- inputs.json
outputs:
  grouped_table_file:
    doc: A table that has been grouped along the given `axis`. IDs on that axis are
      replaced by values in the `metadata` column.
    outputBinding:
      glob: $(inputs.grouped_table)
    type: File
