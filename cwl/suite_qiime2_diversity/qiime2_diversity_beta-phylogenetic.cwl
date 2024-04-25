#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_beta_phylogenetic
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Beta diversity (phylogenetic)
doc: Computes a user-specified phylogenetic beta diversity metric for all pairs of
  samples in a feature table.
inputs:
  table:
    doc: The feature table containing the samples over which beta diversity should
      be computed.
    type: File
  phylogeny:
    doc: Phylogenetic tree containing tip identifiers that correspond to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
    type: File
  metric:
    doc: The beta diversity metric to be computed.
    type: string
  threads:
    default: 1
    doc: The number of CPU threads to use in performing this calculation. May not
      exceed the number of available physical cores. If threads = 'auto', one thread
      will be created for each identified CPU core on the host.
    type: long
  variance_adjusted:
    default: false
    doc: Perform variance adjustment based on Chang et al. BMC Bioinformatics 2011.
      Weights distances based on the proportion of the relative abundance represented
      between the samples at a given node under evaluation.
    type: boolean
  alpha:
    doc: This parameter is only used when the choice of metric is generalized_unifrac.
      The value of alpha controls importance of sample proportions. 1.0 is weighted
      normalized UniFrac. 0.0 is close to unweighted UniFrac, but only if the sample
      proportions are dichotomized.
    type: double?
  bypass_tips:
    default: false
    doc: In a bifurcating tree, the tips make up about 50% of the nodes in a tree.
      By ignoring them, specificity can be traded for reduced compute time. This has
      the effect of collapsing the phylogeny, and is analogous (in concept) to moving
      from 99% to 97% OTUs
    type: boolean
  distance_matrix:
    doc: The resulting distance matrix.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- beta_phylogenetic
- inputs.json
outputs:
  distance_matrix_file:
    doc: The resulting distance matrix.
    outputBinding:
      glob: $(inputs.distance_matrix)
    type: File
