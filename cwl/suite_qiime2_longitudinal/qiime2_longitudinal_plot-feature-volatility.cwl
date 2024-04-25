#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_plot_feature_volatility
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Plot longitudinal feature volatility and importances
doc: Plots an interactive control chart of feature abundances (y-axis) in each sample
  across time (or state; x-axis). Feature importance scores and descriptive statistics
  for each feature are plotted in interactive bar charts below the control chart,
  facilitating exploration of longitudinal feature data. This visualization is intended
  for use with the feature-volatility pipeline; use that pipeline to access this visualization.
inputs:
  table:
    doc: Feature table containing features found in importances.
    type: File
  importances:
    doc: Feature importance scores.
    type: File
  q2cwl_metafile_metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  state_column:
    doc: Metadata column containing state (time) variable information.
    type: string
  individual_id_column:
    doc: Metadata column containing IDs for individual subjects.
    type: string?
  default_group_column:
    doc: The default metadata column on which to separate groups for comparison (all
      categorical metadata columns will be available in the visualization).
    type: string?
  yscale:
    default: linear
    doc: y-axis scaling strategy to apply.
    type: string
  importance_threshold:
    doc: Filter feature table to exclude any features with an importance score less
      than this threshold. Set to "q1", "q2", or "q3" to select the first, second,
      or third quartile of values. Set to "None" to disable this filter.
    type:
    - double?
    - string?
  feature_count:
    default: 100
    doc: Filter feature table to include top N most important features. Set to "all"
      to include all features.
    type:
    - long
    - string
  missing_samples:
    default: error
    doc: How to handle missing samples in metadata. "error" will fail if missing samples
      are detected. "ignore" will cause the feature table and metadata to be filtered,
      so that only samples found in both files are retained.
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- plot_feature_volatility
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
