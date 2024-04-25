#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_regress_samples
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Train and test a cross-validated supervised learning regressor.
doc: Predicts a continuous sample metadata column using a supervised learning regressor.
  Splits input data into training and test sets. The training set is used to train
  and test the estimator using a stratified k-fold cross-validation scheme. This includes
  optional steps for automated feature extraction and hyperparameter optimization.
  The test set validates classification accuracy of the optimized estimator. Outputs
  classification results for test set. For more details on the learning algorithm,
  see http://scikit-learn.org/stable/supervised_learning.html
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
  test_size:
    default: 0.2
    doc: Fraction of input samples to exclude from training set and use for classifier
      testing.
    type: double
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
    default: RandomForestRegressor
    doc: Estimator method to use for sample prediction.
    type: string
  optimize_feature_selection:
    default: false
    doc: Automatically optimize input feature selection using recursive feature elimination.
    type: boolean
  stratify:
    default: false
    doc: Evenly stratify training and test data among metadata categories. If True,
      all values in column must match at least two samples.
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
    doc: Trained sample estimator.
    type: string
  feature_importance:
    doc: Importance of each input feature to model accuracy.
    type: string
  predictions:
    doc: Predicted target values for each input sample.
    type: string
  model_summary:
    doc: Summarized parameter and (if enabled) feature selection information for the
      trained estimator.
    type: string
  accuracy_results:
    doc: Accuracy results visualization.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- regress_samples
- inputs.json
outputs:
  sample_estimator_file:
    doc: Trained sample estimator.
    outputBinding:
      glob: $(inputs.sample_estimator)
    type: File
  feature_importance_file:
    doc: Importance of each input feature to model accuracy.
    outputBinding:
      glob: $(inputs.feature_importance)
    type: File
  predictions_file:
    doc: Predicted target values for each input sample.
    outputBinding:
      glob: $(inputs.predictions)
    type: File
  model_summary_file:
    doc: Summarized parameter and (if enabled) feature selection information for the
      trained estimator.
    outputBinding:
      glob: $(inputs.model_summary)
    type: File
  accuracy_results_file:
    doc: Accuracy results visualization.
    outputBinding:
      glob: $(inputs.accuracy_results)
    type: File
