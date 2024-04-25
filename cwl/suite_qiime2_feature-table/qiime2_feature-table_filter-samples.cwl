#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_filter_samples
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter samples from table
doc: Filter samples from table based on frequency and/or metadata. Any features with
  a frequency of zero after sample filtering will also be removed. See the filtering
  tutorial on https://docs.qiime2.org for additional details.
inputs:
  table:
    doc: The feature table from which samples should be filtered.
    type: File
  min_frequency:
    default: 0
    doc: The minimum total frequency that a sample must have to be retained.
    type: long
  max_frequency:
    doc: The maximum total frequency that a sample can have to be retained. If no
      value is provided this will default to infinity (i.e., no maximum frequency
      filter will be applied).
    type: long?
  min_features:
    default: 0
    doc: The minimum number of features that a sample must have to be retained.
    type: long
  max_features:
    doc: The maximum number of features that a sample can have to be retained. If
      no value is provided this will default to infinity (i.e., no maximum feature
      filter will be applied).
    type: long?
  q2cwl_metafile_metadata:
    doc: Sample metadata used with `where` parameter when selecting samples to retain,
      or with `exclude_ids` when selecting samples to discard.
    type:
    - File?
    - File[]?
  where:
    doc: SQLite WHERE clause specifying sample metadata criteria that must be met
      to be included in the filtered feature table. If not provided, all samples in
      `metadata` that are also in the feature table will be retained.
    type: string?
  exclude_ids:
    default: false
    doc: If true, the samples selected by `metadata` or `where` parameters will be
      excluded from the filtered table instead of being retained.
    type: boolean
  filter_empty_features:
    default: true
    doc: If true, features which are not present in any retained samples are dropped.
    type: boolean
  allow_empty_table:
    default: false
    doc: If true, the filtered table may be empty. Default behavior is to raise an
      error if the filtered table is empty.
    type: boolean
  filtered_table:
    doc: The resulting feature table filtered by sample.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- filter_samples
- inputs.json
outputs:
  filtered_table_file:
    doc: The resulting feature table filtered by sample.
    outputBinding:
      glob: $(inputs.filtered_table)
    type: File
