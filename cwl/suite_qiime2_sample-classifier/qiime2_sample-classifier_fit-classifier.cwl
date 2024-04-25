#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_fit_classifier
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Fit a supervised learning classifier.
doc: Fit a supervised learning classifier. Outputs the fit estimator (for prediction
  of test samples and/or unknown samples) and the relative importance of each feature
  for model accuracy. Optionally use k-fold cross-validation for automatic recursive
  feature elimination and hyperparameter tuning.
inputs:
  table:
    doc: Feature table containing all features that should be used for target prediction.
    type: File
  q2cwl_metafile_metadata:
    doc: Numeric metadata column to use as prediction target.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  step:
    default: 0.05
    doc: If optimize_feature_selection is True, step is the percentage of features
      to remove at each iteration.
    type: double
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
  n_estimators:
    default: 100
    doc: Number of trees to grow for estimation. More trees will improve predictive
      accuracy up to a threshold level, but will also increase time and memory requirements.
      This parameter only affects ensemble estimators, such as Random Forest, AdaBoost,
      ExtraTrees, and GradientBoosting.
    type: long
  estimator:
    default: RandomForestClassifier
    doc: Estimator method to use for sample prediction.
    type: string
  optimize_feature_selection:
    default: false
    doc: Automatically optimize input feature selection using recursive feature elimination.
    type: boolean
  parameter_tuning:
    default: false
    doc: Automatically tune hyperparameters using random grid search.
    type: boolean
  missing_samples:
    default: error
    doc: How to handle missing samples in metadata. "error" will fail if missing samples
      are detected. "ignore" will cause the feature table and metadata to be filtered,
      so that only samples found in both files are retained.
    type: string
  sample_estimator:
    doc: Trained sample classifier.
    type: string
  feature_importance:
    doc: Importance of each input feature to model accuracy.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- fit_classifier
- inputs.json
outputs:
  sample_estimator_file:
    doc: Trained sample classifier.
    outputBinding:
      glob: $(inputs.sample_estimator)
    type: File
  feature_importance_file:
    doc: Importance of each input feature to model accuracy.
    outputBinding:
      glob: $(inputs.feature_importance)
    type: File
