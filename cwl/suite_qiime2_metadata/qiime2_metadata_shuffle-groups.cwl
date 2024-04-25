#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_metadata_shuffle_groups
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Shuffle values in a categorical sample metadata column.
doc: Create one or more categorical sample metadata columns by shuffling the values
  in an input metadata column. To avoid confusion, the column name and values will
  be derived from the provided prefixes. The number of different values (or groups),
  and the counts of each value, will match the input metadata column but the association
  of values with sample ids will be random. These data will be written to an artifact
  that can be used as sample metadata.
inputs:
  q2cwl_metafile_metadata:
    doc: Categorical metadata column to shuffle.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  n_columns:
    default: 3
    doc: The number of shuffled metadata columns to create.
    type: long
  md_column_name_prefix:
    default: shuffled.grouping.
    doc: Prefix to use in naming the shuffled metadata columns.
    type: string
  md_column_values_prefix:
    default: fake.group.
    doc: Prefix to use in naming the values in the shuffled metadata columns.
    type: string
  encode_sample_size:
    default: false
    doc: If true, the sample size of each metadata group will be appended to the shuffled
      metadata column values.
    type: boolean
  shuffled_groups:
    doc: Randomized metadata columns
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- metadata
- shuffle_groups
- inputs.json
outputs:
  shuffled_groups_file:
    doc: Randomized metadata columns
    outputBinding:
      glob: $(inputs.shuffled_groups)
    type: File
