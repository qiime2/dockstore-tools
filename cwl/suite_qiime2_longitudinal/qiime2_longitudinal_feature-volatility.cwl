#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_feature_volatility
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Feature volatility analysis
doc: Identify features that are predictive of a numeric metadata column, state_column
  (e.g., time), and plot their relative frequencies across states using interactive
  feature volatility plots. A supervised learning regressor is used to identify important
  features and assess their ability to predict sample states. state_column will typically
  be a measure of time, but any numeric metadata column can be used.
inputs:
  table:
    doc: Feature table containing all features that should be used for target prediction.
    type: File
  q2cwl_metafile_metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  state_column:
    doc: Metadata containing collection time (state) values for each sample. Must
      contain exclusively numeric values.
    type: string
  individual_id_column:
    doc: Metadata column containing IDs for individual subjects.
    type: string?
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
    default: RandomForestRegressor
    doc: Estimator method to use for sample prediction.
    type: string
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
  filtered_table:
    doc: Feature table containing only important features.
    type: string
  feature_importance:
    doc: Importance of each input feature to model accuracy.
    type: string
  volatility_plot:
    doc: Interactive volatility plot visualization.
    type: string
  accuracy_results:
    doc: Accuracy results visualization.
    type: string
  sample_estimator:
    doc: Trained sample regressor.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- feature_volatility
- inputs.json
outputs:
  filtered_table_file:
    doc: Feature table containing only important features.
    outputBinding:
      glob: $(inputs.filtered_table)
    type: File
  feature_importance_file:
    doc: Importance of each input feature to model accuracy.
    outputBinding:
      glob: $(inputs.feature_importance)
    type: File
  volatility_plot_file:
    doc: Interactive volatility plot visualization.
    outputBinding:
      glob: $(inputs.volatility_plot)
    type: File
  accuracy_results_file:
    doc: Accuracy results visualization.
    outputBinding:
      glob: $(inputs.accuracy_results)
    type: File
  sample_estimator_file:
    doc: Trained sample regressor.
    outputBinding:
      glob: $(inputs.sample_estimator)
    type: File
