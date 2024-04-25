#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_anova
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: ANOVA test
doc: Perform an ANOVA test on any factors present in a metadata file and/or metadata-transformable
  artifacts. This is followed by pairwise t-tests to examine pairwise differences
  between categorical sample groups.
inputs:
  q2cwl_metafile_metadata:
    doc: Sample metadata containing formula terms.
    type:
    - File
    - File[]
  formula:
    doc: R-style formula specifying the model. All terms must be present in the sample
      metadata or metadata-transformable artifacts and can be continuous or categorical
      metadata columns. Formulae will be in the format "a ~ b + c", where "a" is the
      metric (dependent variable) and "b" and "c" are independent covariates. Use
      "+" to add a variable; "+ a:b" to add an interaction between variables a and
      b; "*" to include a variable and all interactions; and "-" to subtract a particular
      term (e.g., an interaction term). See https://patsy.readthedocs.io/en/latest/formulas.html
      for full documentation of valid formula operators. Always enclose formulae in
      quotes to avoid unpleasant surprises.
    type: string
  sstype:
    default: II
    doc: Type of sum of squares calculation to perform (I, II, or III).
    type: string
  repeated_measures:
    default: false
    doc: 'Perform ANOVA as a repeated measures ANOVA. Implemented via statsmodels,
      which has the following limitations: Currently, only fully balanced within-subject
      designs are supported. Calculation of between-subject effects and corrections
      for violation of sphericity are not yet implemented.'
    type: boolean
  individual_id_column:
    doc: The column containing individual ID with repeated measures to account for.This
      should not be included in the formula.
    type: string?
  rm_aggregate:
    default: false
    doc: 'If the data set contains more than a single observation per individual id
      and cell of the specified model, this function will be used to aggregate the
      data by the mean before running the ANOVA. Only applicable for repeated measures
      ANOVA. '
    type: boolean
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- anova
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
