#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_volatility
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Generate interactive volatility plot
doc: Generate an interactive control chart depicting the longitudinal volatility of
  sample metadata and/or feature frequencies across time (as set using the "state_column"
  parameter). Any numeric metadata column (and metadata-transformable artifacts, e.g.,
  alpha diversity results) can be plotted on the y-axis, and are selectable using
  the "metric_column" selector. Metric values are averaged to compare across any categorical
  metadata column using the "group_column" selector. Longitudinal volatility for individual
  subjects sampled over time is co-plotted as "spaghetti" plots if the "individual_id_column"
  parameter is used. state_column will typically be a measure of time, but any numeric
  metadata column can be used.
inputs:
  table:
    doc: Feature table containing metrics.
    type: File?
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
  default_metric:
    doc: Numeric metadata or artifact column to test by default (all numeric metadata
      columns will be available in the visualization).
    type: string?
  yscale:
    default: linear
    doc: y-axis scaling strategy to apply.
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- volatility
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
