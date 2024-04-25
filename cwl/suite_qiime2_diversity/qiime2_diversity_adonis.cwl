#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_adonis
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: adonis PERMANOVA test for beta group significance
doc: 'Determine whether groups of samples are significantly different from one another
  using the ADONIS permutation-based statistical test in vegan-R. The function partitions
  sums of squares of a multivariate data set, and is directly analogous to MANOVA
  (multivariate analysis of variance). This action differs from beta_group_significance
  in that it accepts R formulae to perform multi-way ADONIS tests; beta_group_signficance
  only performs one-way tests. For more details, consult the reference manual available
  on the CRAN vegan page: https://CRAN.R-project.org/package=vegan'
inputs:
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    type: File
  q2cwl_metafile_metadata:
    doc: Sample metadata containing formula terms.
    type:
    - File
    - File[]
  formula:
    doc: Model formula containing only independent terms contained in the sample metadata.
      These can be continuous variables or factors, and they can have interactions
      as in a typical R formula. E.g., the formula "treatment+block" would test whether
      the input distance matrix partitions based on "treatment" and "block" sample
      metadata. The formula "treatment*block" would test both of those effects as
      well as their interaction. Enclose formulae in quotes to avoid unpleasant surprises.
    type: string
  permutations:
    default: 999
    doc: The number of permutations to be run when computing p-values.
    type: long
  n_jobs:
    default: 1
    doc: Number of parallel processes to run.
    type: long
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- adonis
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
