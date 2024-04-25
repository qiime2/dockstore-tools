#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_filter_features_conditionally
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter features from a table based on abundance and prevalence
doc: Filter features based on the relative abundance in a certain portion of samples
  (i.e., features must have a relative abundance of at least `abundance` in at least
  `prevalence` number of samples). Any samples with a frequency of zero after feature
  filtering will also be removed.
inputs:
  table:
    doc: The feature table from which features should be filtered.
    type: File
  abundance:
    doc: The minimum relative abundance for a feature to be retained.
    type: double
  prevalence:
    doc: The minimum portion of samples that a feature must have a relative abundance
      of at least `abundance` to be retained.
    type: double
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
- filter_features_conditionally
- inputs.json
outputs:
  filtered_table_file:
    doc: The resulting feature table filtered by feature.
    outputBinding:
      glob: $(inputs.filtered_table)
    type: File
