#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_umap
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Uniform Manifold Approximation and Projection
doc: Apply Uniform Manifold Approximation and Projection.
inputs:
  distance_matrix:
    doc: The distance matrix on which UMAP should be computed.
    type: File
  number_of_dimensions:
    default: 2
    doc: Dimensions to reduce the distance matrix to.
    type: long
  n_neighbors:
    default: 15
    doc: Provide the balance between local and global structure. Low values prioritize
      the preservation of local structures. Large values sacrifice local details for
      a broader global embedding.
    type: long
  min_dist:
    default: 0.4
    doc: 'Controls the cluster size. Low values cause clumpier clusters. Higher values
      preserve a broad topological structure. To get less overlapping data points
      the default value is set to 0.4. For more details visit: https://umap-learn.readthedocs.io/en/latest/parameters.html'
    type: double
  random_state:
    doc: Seed used by random number generator.
    type: long?
  umap:
    doc: The resulting UMAP matrix.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- umap
- inputs.json
outputs:
  umap_file:
    doc: The resulting UMAP matrix.
    outputBinding:
      glob: $(inputs.umap)
    type: File
