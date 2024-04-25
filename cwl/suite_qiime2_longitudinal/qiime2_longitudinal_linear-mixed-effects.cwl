#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_linear_mixed_effects
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Linear mixed effects modeling
doc: Linear mixed effects models evaluate the contribution of exogenous covariates
  "group_columns" and "random_effects" to a single dependent variable, "metric". Perform
  LME and plot line plots of each group column. A feature table artifact is required
  input, though whether "metric" is derived from the feature table or metadata is
  optional.
inputs:
  table:
    doc: Feature table containing metric.
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
    type: string
  metric:
    doc: Dependent variable column name. Must be a column name located in the metadata
      or feature table files.
    type: string?
  group_columns:
    doc: Comma-separated list (without spaces) of metadata columns to use as independent
      covariates used to determine mean structure of "metric".
    type: string?
  random_effects:
    doc: Comma-separated list (without spaces) of metadata columns to use as independent
      covariates used to determine the variance and covariance structure (random effects)
      of "metric". To add a random slope, the same value passed to "state_column"
      should be passed here. A random intercept for each individual is set by default
      and does not need to be passed here.
    type: string?
  palette:
    default: Set1
    doc: Color palette to use for generating boxplots.
    type: string
  lowess:
    default: false
    doc: Estimate locally weighted scatterplot smoothing. Note that this will eliminate
      confidence interval plotting.
    type: boolean
  ci:
    default: 95
    doc: Size of the confidence interval for the regression estimate.
    type: double
  formula:
    doc: R-style formula to use for model specification. A formula must be used if
      the "metric" parameter is None. Note that the metric and group columns specified
      in the formula will override metric and group columns that are passed separately
      as parameters to this method. Formulae will be in the format "a ~ b + c", where
      "a" is the metric (dependent variable) and "b" and "c" are independent covariates.
      Use "+" to add a variable; "+ a:b" to add an interaction between variables a
      and b; "*" to include a variable and all interactions; and "-" to subtract a
      particular term (e.g., an interaction term). See https://patsy.readthedocs.io/en/latest/formulas.html
      for full documentation of valid formula operators. Always enclose formulae in
      quotes to avoid unpleasant surprises.
    type: string?
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- linear_mixed_effects
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
