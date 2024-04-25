#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_tsne
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: t-distributed stochastic neighbor embedding
doc: Apply t-distributed stochastic neighbor embedding.
inputs:
  distance_matrix:
    doc: The distance matrix on which t-SNE should be computed.
    type: File
  number_of_dimensions:
    default: 2
    doc: Dimensions to reduce the distance matrix to.
    type: long
  perplexity:
    default: 25.0
    doc: Provide the balance between local and global structure. Low values concentrate
      on local structure. Large values sacrifice local details for a broader global
      embedding. The default value is 25 to achieve better results for small microbiome
      datasets.
    type: double
  n_iter:
    default: 1000
    doc: null
    type: long
  learning_rate:
    default: 200.0
    doc: Controls how much the weights are adjusted at each update.
    type: double
  early_exaggeration:
    default: 12.0
    doc: Affects the tightness of the shown clusters. Larger values increase the distance
      between natural clusters in the embedded space.
    type: double
  random_state:
    doc: Seed used by random number generator.
    type: long?
  tsne:
    doc: The resulting t-SNE matrix.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- tsne
- inputs.json
outputs:
  tsne_file:
    doc: The resulting t-SNE matrix.
    outputBinding:
      glob: $(inputs.tsne)
    type: File
