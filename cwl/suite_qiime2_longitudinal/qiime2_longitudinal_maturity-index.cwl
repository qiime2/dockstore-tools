#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_maturity_index
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Microbial maturity index prediction.
doc: Calculates a "microbial maturity" index from a regression model trained on feature
  data to predict a given continuous metadata column, e.g., to predict age as a function
  of microbiota composition. The model is trained on a subset of control group samples,
  then predicts the column value for all samples. This visualization computes maturity
  index z-scores to compare relative "maturity" between each group, as described in
  doi:10.1038/nature13421. This method can be used to predict between-group differences
  in relative trajectory across any type of continuous metadata gradient, e.g., intestinal
  microbiome development by age, microbial succession during wine fermentation, or
  microbial community differences along environmental gradients, as a function of
  two or more different "treatment" groups.
inputs:
  table:
    doc: Feature table containing all features that should be used for target prediction.
    type: File
  q2cwl_metafile_metadata:
    doc: null
    type:
    - File
    - File[]
  state_column:
    doc: Numeric metadata column containing sampling time (state) data to use as prediction
      target.
    type: string
  group_by:
    doc: Categorical metadata column to use for plotting and significance testing
      between main treatment groups.
    type: string
  control:
    doc: Value of group_by to use as control group. The regression model will be trained
      using only control group data, and the maturity scores of other groups consequently
      will be assessed relative to this group.
    type: string
  individual_id_column:
    doc: Optional metadata column containing IDs for individual subjects. Adds individual
      subject (spaghetti) vectors to volatility charts if a column name is provided.
    type: string?
  estimator:
    default: RandomForestRegressor
    doc: Regression model to use for prediction.
    type: string
  n_estimators:
    default: 100
    doc: Number of trees to grow for estimation. More trees will improve predictive
      accuracy up to a threshold level, but will also increase time and memory requirements.
      This parameter only affects ensemble estimators, such as Random Forest, AdaBoost,
      ExtraTrees, and GradientBoosting.
    type: long
  test_size:
    default: 0.5
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
  parameter_tuning:
    default: false
    doc: Automatically tune hyperparameters using random grid search.
    type: boolean
  optimize_feature_selection:
    default: false
    doc: Automatically optimize input feature selection using recursive feature elimination.
    type: boolean
  stratify:
    default: false
    doc: Evenly stratify training and test data among metadata categories. If True,
      all values in column must match at least two samples.
    type: boolean
  missing_samples:
    default: error
    doc: How to handle missing samples in metadata. "error" will fail if missing samples
      are detected. "ignore" will cause the feature table and metadata to be filtered,
      so that only samples found in both files are retained.
    type: string
  feature_count:
    default: 50
    doc: Filter feature table to include top N most important features. Set to zero
      to include all features.
    type: long
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
  maz_scores:
    doc: Microbiota-for-age z-score predictions.
    type: string
  clustermap:
    doc: Heatmap of important feature abundance at each time point in each group.
    type: string
  volatility_plots:
    doc: Interactive volatility plots of MAZ and maturity scores, target (column)
      predictions, and the sample metadata.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- maturity_index
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
  maz_scores_file:
    doc: Microbiota-for-age z-score predictions.
    outputBinding:
      glob: $(inputs.maz_scores)
    type: File
  clustermap_file:
    doc: Heatmap of important feature abundance at each time point in each group.
    outputBinding:
      glob: $(inputs.clustermap)
    type: File
  volatility_plots_file:
    doc: Interactive volatility plots of MAZ and maturity scores, target (column)
      predictions, and the sample metadata.
    outputBinding:
      glob: $(inputs.volatility_plots)
    type: File
