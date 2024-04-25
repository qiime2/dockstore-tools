#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_predict_regression
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Use trained regressor to predict target values for new samples.
doc: Use trained estimator to predict target values for new samples. These will typically
  be unseen samples, e.g., test data (derived manually or from split_table) or samples
  with unknown values, but can theoretically be any samples present in a feature table
  that contain overlapping features with the feature table used to train the estimator.
inputs:
  table:
    doc: Feature table containing all features that should be used for target prediction.
    type: File
  sample_estimator:
    doc: Sample regressor trained with fit_regressor.
    type: File
  n_jobs:
    default: 1
    doc: Number of jobs to run in parallel.
    type: long
  predictions:
    doc: Predicted target values for each input sample.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- predict_regression
- inputs.json
outputs:
  predictions_file:
    doc: Predicted target values for each input sample.
    outputBinding:
      glob: $(inputs.predictions)
    type: File
