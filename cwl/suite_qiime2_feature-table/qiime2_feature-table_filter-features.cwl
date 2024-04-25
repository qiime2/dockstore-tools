#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_filter_features
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter features from table
doc: Filter features from table based on frequency and/or metadata. Any samples with
  a frequency of zero after feature filtering will also be removed. See the filtering
  tutorial on https://docs.qiime2.org for additional details.
inputs:
  table:
    doc: The feature table from which features should be filtered.
    type: File
  min_frequency:
    default: 0
    doc: The minimum total frequency that a feature must have to be retained.
    type: long
  max_frequency:
    doc: The maximum total frequency that a feature can have to be retained. If no
      value is provided this will default to infinity (i.e., no maximum frequency
      filter will be applied).
    type: long?
  min_samples:
    default: 0
    doc: The minimum number of samples that a feature must be observed in to be retained.
    type: long
  max_samples:
    doc: The maximum number of samples that a feature can be observed in to be retained.
      If no value is provided this will default to infinity (i.e., no maximum sample
      filter will be applied).
    type: long?
  q2cwl_metafile_metadata:
    doc: Feature metadata used with `where` parameter when selecting features to retain,
      or with `exclude_ids` when selecting features to discard.
    type:
    - File?
    - File[]?
  where:
    doc: SQLite WHERE clause specifying feature metadata criteria that must be met
      to be included in the filtered feature table. If not provided, all features
      in `metadata` that are also in the feature table will be retained.
    type: string?
  exclude_ids:
    default: false
    doc: If true, the features selected by `metadata` or `where` parameters will be
      excluded from the filtered table instead of being retained.
    type: boolean
  filter_empty_samples:
    default: true
    doc: If true, drop any samples where none of the retained features are present.
    type: boolean
  allow_empty_table:
    default: false
    doc: If true, the filtered table may be empty. Default behavior is to raise an
      error if the filtered table is empty.
    type: boolean
  filtered_table:
    doc: The resulting feature table filtered by feature.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- filter_features
- inputs.json
outputs:
  filtered_table_file:
    doc: The resulting feature table filtered by feature.
    outputBinding:
      glob: $(inputs.filtered_table)
    type: File
