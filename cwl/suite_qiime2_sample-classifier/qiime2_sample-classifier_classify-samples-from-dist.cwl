#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_classify_samples_from_dist
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Run k-nearest-neighbors on a labeled distance matrix.
doc: Run k-nearest-neighbors on a labeled distance matrix. Return cross-validated
  (leave one out) predictions and  accuracy. k = 1 by default
inputs:
  distance_matrix:
    doc: a distance matrix
    type: File
  q2cwl_metafile_metadata:
    doc: Categorical metadata column to use as prediction target.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  k:
    default: 1
    doc: Number of nearest neighbors
    type: long
  cv:
    default: 5
    doc: Number of k-fold cross-validations to perform.
    type: long
  random_state:
    doc: Seed used by random number generator.
    type: long?
  n_jobs:
    default: 1
    doc: Number of jobs to run in parallel.
    type: long
  palette:
    default: sirocco
    doc: The color palette to use for plotting.
    type: string
  predictions:
    doc: leave one out predictions for each sample
    type: string
  accuracy_results:
    doc: Accuracy results visualization.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- classify_samples_from_dist
- inputs.json
outputs:
  predictions_file:
    doc: leave one out predictions for each sample
    outputBinding:
      glob: $(inputs.predictions)
    type: File
  accuracy_results_file:
    doc: Accuracy results visualization.
    outputBinding:
      glob: $(inputs.accuracy_results)
    type: File
