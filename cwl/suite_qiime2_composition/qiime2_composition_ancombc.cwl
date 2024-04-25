#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_composition_ancombc
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Analysis of Composition of Microbiomes with Bias Correction
doc: Apply Analysis of Compositions of Microbiomes with Bias Correction (ANCOM-BC)
  to identify features that are differentially abundant across groups.
inputs:
  table:
    doc: The feature table to be used for ANCOM-BC computation.
    type: File
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
  formula:
    doc: How the microbial absolute abundances for each taxon depend on the variables
      within the `metadata`.
    type: string
  p_adj_method:
    default: holm
    doc: Method to adjust p-values.
    type: string
  prv_cut:
    default: 0.1
    doc: A numerical fraction between 0-1. Taxa with prevalences less than this value
      will be excluded from the analysis.
    type: double
  lib_cut:
    default: 0
    doc: A numerical threshold for filtering samples based on library sizes. Samples
      with library sizes less than this value will be excluded from the analysis.
    type: long
  reference_levels:
    doc: 'Define the reference level(s) to be used for categorical columns found in
      the `formula`. These categorical factors are dummy coded relative to the reference(s)
      provided. The syntax is as follows: "column_name::column_value"'
    type: string[]?
  tol:
    default: 1.0e-05
    doc: The iteration convergence tolerance for the E-M algorithm.
    type: double
  max_iter:
    default: 100
    doc: The maximum number of iterations for the E-M algorithm.
    type: long
  conserve:
    default: false
    doc: Whether to use a conservative variance estimator for the test statistic.
      It is recommended if the sample size is small and/or the number of differentially
      abundant taxa is believed to be large.
    type: boolean
  alpha:
    default: 0.05
    doc: Level of significance.
    type: double
  differentials:
    doc: The calculated per-feature differentials.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- composition
- ancombc
- inputs.json
outputs:
  differentials_file:
    doc: The calculated per-feature differentials.
    outputBinding:
      glob: $(inputs.differentials)
    type: File
