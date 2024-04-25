#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_pairwise_distances
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Paired pairwise distance testing and boxplots
doc: Performs pairwise distance testing between sample pairs from each subject. Sample
  pairs may represent a typical intervention study, e.g., samples collected pre- and
  post-treatment; paired samples from two different timepoints (e.g., in a longitudinal
  study design), or identical samples receiving different two different treatments.
  This action tests whether the pairwise distance between each subject pair differs
  between groups (e.g., groups of subjects receiving different treatments) and produces
  boxplots of paired distance distributions for each group.
inputs:
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    type: File
  q2cwl_metafile_metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  group_column:
    doc: Metadata column on which to separate groups for comparison
    type: string
  state_column:
    doc: Metadata column containing state (e.g., Time) across which samples are paired.
    type: string
  state_1:
    doc: Baseline state column value.
    type: string
  state_2:
    doc: State column value to pair with baseline.
    type: string
  individual_id_column:
    doc: 'Metadata column containing subject IDs to use for pairing samples. WARNING:
      if replicates exist for an individual ID at either state_1 or state_2, that
      subject will be dropped and reported in standard output by default. Set replicate_handling="random"
      to instead randomly select one member.'
    type: string
  parametric:
    default: false
    doc: Perform parametric (ANOVA and t-tests) or non-parametric (Kruskal-Wallis,
      Wilcoxon, and Mann-Whitney U tests) statistical tests.
    type: boolean
  palette:
    default: Set1
    doc: Color palette to use for generating boxplots.
    type: string
  replicate_handling:
    default: error
    doc: Choose how replicate samples are handled. If replicates are detected, "error"
      causes method to fail; "drop" will discard all replicated samples; "random"
      chooses one representative at random from among replicates.
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- pairwise_distances
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
