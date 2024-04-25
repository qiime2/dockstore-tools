#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_beta_rarefaction
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Beta diversity rarefaction
doc: 'Repeatedly rarefy a feature table to compare beta diversity results within a
  given rarefaction depth.


  For a given beta diversity metric, this visualizer will provide: an Emperor jackknifed
  PCoA plot, samples clustered by UPGMA or neighbor joining with support calculation,
  and a heatmap showing the correlation between rarefaction trials of that beta diversity
  metric.'
inputs:
  table:
    doc: Feature table upon which to perform beta diversity rarefaction analyses.
    type: File
  phylogeny:
    doc: Phylogenetic tree containing tip identifiers that correspond to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
      [required for phylogenetic metrics]
    type: File?
  metric:
    doc: The beta diversity metric to be computed.
    type: string
  clustering_method:
    doc: Samples can be clustered with neighbor joining or UPGMA. An arbitrary rarefaction
      trial will be used for the tree, and the remaining trials are used to calculate
      the support of the internal nodes of that tree.
    type: string
  q2cwl_metafile_metadata:
    doc: The sample metadata used for the Emperor jackknifed PCoA plot.
    type:
    - File
    - File[]
  sampling_depth:
    doc: The total frequency that each sample should be rarefied to prior to computing
      the diversity metric.
    type: long
  iterations:
    default: 10
    doc: Number of times to rarefy the feature table at a given sampling depth.
    type: long
  correlation_method:
    default: spearman
    doc: The Mantel correlation test to be applied when computing correlation between
      beta diversity distance matrices.
    type: string
  color_scheme:
    default: BrBG
    doc: The matplotlib color scheme to generate the heatmap with.
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- beta_rarefaction
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
