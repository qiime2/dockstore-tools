#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_alpha_rarefaction
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Alpha rarefaction curves
doc: Generate interactive alpha rarefaction curves by computing rarefactions between
  `min_depth` and `max_depth`. The number of intermediate depths to compute is controlled
  by the `steps` parameter, with n `iterations` being computed at each rarefaction
  depth. If sample metadata is provided, samples may be grouped based on distinct
  values within a metadata column.
inputs:
  table:
    doc: Feature table to compute rarefaction curves from.
    type: File
  phylogeny:
    doc: Optional phylogeny for phylogenetic metrics.
    type: File?
  max_depth:
    doc: The maximum rarefaction depth. Must be greater than min_depth.
    type: long
  metrics:
    doc: The metrics to be measured. By default computes observed_features, shannon,
      and if phylogeny is provided, faith_pd.
    type: string[]?
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File?
    - File[]?
  min_depth:
    default: 1
    doc: The minimum rarefaction depth.
    type: long
  steps:
    default: 10
    doc: The number of rarefaction depths to include between min_depth and max_depth.
    type: long
  iterations:
    default: 10
    doc: The number of rarefied feature tables to compute at each step.
    type: long
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- alpha_rarefaction
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
