#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_scatterplot
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Make 2D scatterplot and linear regression of regressor predictions.
doc: Make a 2D scatterplot and linear regression of predicted vs. true values for
  a set of samples predicted using a sample regressor.
inputs:
  predictions:
    doc: Predicted values to plot on y axis. Must be predictions of numeric data produced
      by a sample regressor.
    type: File
  q2cwl_metafile_truth:
    doc: Metadata column (true values) to plot on x axis.
    type: File
  truth:
    doc: Column name to use from 'truth' file
    type: string
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
- sample_classifier
- scatterplot
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
