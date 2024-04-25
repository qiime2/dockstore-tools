#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_classify_samples
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Train and test a cross-validated supervised learning classifier.
doc: Predicts a categorical sample metadata column using a supervised learning classifier.
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
    doc: Categorical metadata column to use as prediction target.
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
  palette:
    default: sirocco
    doc: The color palette to use for plotting.
    type: string
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
  probabilities:
    doc: Predicted class probabilities for each input sample.
    type: string
  heatmap:
    doc: A heatmap of the top 50 most important features from the table.
    type: string
  training_targets:
    doc: Series containing true target values of train samples
    type: string
  test_targets:
    doc: Series containing true target values of test samples
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- classify_samples
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
  probabilities_file:
    doc: Predicted class probabilities for each input sample.
    outputBinding:
      glob: $(inputs.probabilities)
    type: File
  heatmap_file:
    doc: A heatmap of the top 50 most important features from the table.
    outputBinding:
      glob: $(inputs.heatmap)
    type: File
  training_targets_file:
    doc: Series containing true target values of train samples
    outputBinding:
      glob: $(inputs.training_targets)
    type: File
  test_targets_file:
    doc: Series containing true target values of test samples
    outputBinding:
      glob: $(inputs.test_targets)
    type: File
