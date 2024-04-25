#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_beta_correlation
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Beta diversity correlation
doc: 'Create a distance matrix from a numeric metadata column and apply a two-sided
  Mantel test to identify correlation between two distance matrices. Actions used
  internally: `distance-matrix` from q2-metadata and `mantel` from q2-diversity.'
inputs:
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    type: File
  q2cwl_metafile_metadata:
    doc: Numeric metadata column from which to compute pairwise Euclidean distances
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  method:
    default: spearman
    doc: The correlation test to be applied in the Mantel test.
    type: string
  permutations:
    default: 999
    doc: The number of permutations to be run when computing p-values. Supplying a
      value of zero will disable permutation testing and p-values will not be calculated
      (this results in *much* quicker execution time if p-values are not desired).
    type: long
  intersect_ids:
    default: false
    doc: If supplied, IDs that are not found in both distance matrices will be discarded
      before applying the Mantel test. Default behavior is to error on any mismatched
      IDs.
    type: boolean
  label1:
    default: Metadata
    doc: Label for `distance_matrix` in the output visualization.
    type: string
  label2:
    default: Distance Matrix
    doc: Label for `metadata_distance_matrix` in the output visualization.
    type: string
  metadata_distance_matrix:
    doc: The Distance Matrix produced from the metadata column and used in the mantel
      test
    type: string
  mantel_scatter_visualization:
    doc: Scatter plot rendering of the manteltest results
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- beta_correlation
- inputs.json
outputs:
  metadata_distance_matrix_file:
    doc: The Distance Matrix produced from the metadata column and used in the mantel
      test
    outputBinding:
      glob: $(inputs.metadata_distance_matrix)
    type: File
  mantel_scatter_visualization_file:
    doc: Scatter plot rendering of the manteltest results
    outputBinding:
      glob: $(inputs.mantel_scatter_visualization)
    type: File
