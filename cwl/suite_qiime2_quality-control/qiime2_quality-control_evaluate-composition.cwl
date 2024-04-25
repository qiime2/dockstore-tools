#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_evaluate_composition
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Evaluate expected vs. observed taxonomic composition of samples
doc: This visualizer compares the feature composition of pairs of observed and expected
  samples containing the same sample ID in two separate feature tables. Typically,
  feature composition will consist of taxonomy classifications or other semicolon-delimited
  feature annotations. Taxon accuracy rate, taxon detection rate, and linear regression
  scores between expected and observed observations are calculated at each semicolon-delimited
  rank, and plots of per-level accuracy and observation correlations are plotted.
  A histogram of distance between false positive observations and the nearest expected
  feature is also generated, where distance equals the number of rank differences
  between the observed feature and the nearest common lineage in the expected feature.
  This visualizer is most suitable for testing per-run data quality on sequencing
  runs that contain mock communities or other samples with known composition. Also
  suitable for sanity checks of bioinformatics pipeline performance.
inputs:
  expected_features:
    doc: Expected feature compositions
    type: File
  observed_features:
    doc: Observed feature compositions
    type: File
  depth:
    default: 7
    doc: Maximum depth of semicolon-delimited taxonomic ranks to test (e.g., 1 = root,
      7 = species for the greengenes reference sequence database).
    type: long
  palette:
    default: Set1
    doc: Color palette to utilize for plotting.
    type: string
  plot_tar:
    default: true
    doc: Plot taxon accuracy rate (TAR) on score plot. TAR is the number of true positive
      features divided by the total number of observed features (TAR = true positives
      / (true positives + false positives)).
    type: boolean
  plot_tdr:
    default: true
    doc: Plot taxon detection rate (TDR) on score plot. TDR is the number of true
      positive features divided by the total number of expected features (TDR = true
      positives / (true positives + false negatives)).
    type: boolean
  plot_r_value:
    default: false
    doc: Plot expected vs. observed linear regression r value on score plot.
    type: boolean
  plot_r_squared:
    default: true
    doc: Plot expected vs. observed linear regression r-squared value on score plot.
    type: boolean
  plot_bray_curtis:
    default: false
    doc: Plot expected vs. observed Bray-Curtis dissimilarity scores on score plot.
    type: boolean
  plot_jaccard:
    default: false
    doc: Plot expected vs. observed Jaccard distances scores on score plot.
    type: boolean
  plot_observed_features:
    default: false
    doc: Plot observed features count on score plot.
    type: boolean
  plot_observed_features_ratio:
    default: true
    doc: Plot ratio of observed:expected features on score plot.
    type: boolean
  q2cwl_metafile_metadata:
    doc: Optional sample metadata that maps observed_features sample IDs to expected_features
      sample IDs.
    type: File?
  metadata:
    doc: Column name to use from 'metadata' file
    type: string?
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- evaluate_composition
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
