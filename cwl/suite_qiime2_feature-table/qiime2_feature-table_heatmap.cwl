#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_heatmap
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Generate a heatmap representation of a feature table
doc: 'Generate a heatmap representation of a feature table with optional clustering
  on both the sample and feature axes.


  Tip: To generate a heatmap containing taxonomic annotations, use `qiime taxa collapse`
  to collapse the feature table at the desired taxonomic level.'
inputs:
  table:
    doc: The feature table to visualize.
    type: File
  q2cwl_metafile_sample_metadata:
    doc: Annotate the sample IDs with these sample metadata values. When metadata
      is present and `cluster`='feature', samples will be sorted by the metadata values.
    type: File?
  sample_metadata:
    doc: Column name to use from 'sample_metadata' file
    type: string?
  q2cwl_metafile_feature_metadata:
    doc: Annotate the feature IDs with these feature metadata values. When metadata
      is present and `cluster`='sample', features will be sorted by the metadata values.
    type: File?
  feature_metadata:
    doc: Column name to use from 'feature_metadata' file
    type: string?
  normalize:
    default: true
    doc: Normalize the feature table by adding a psuedocount of 1 and then taking
      the log10 of the table.
    type: boolean
  title:
    doc: Optional custom plot title.
    type: string?
  metric:
    default: euclidean
    doc: Metrics exposed by seaborn (see http://seaborn.pydata.org/generated/seaborn.clustermap.html#seaborn.clustermap
      for more detail).
    type: string
  method:
    default: average
    doc: Clustering methods exposed by seaborn (see http://seaborn.pydata.org/generated/seaborn.clustermap.html#seaborn.clustermap
      for more detail).
    type: string
  cluster:
    default: both
    doc: Specify which axes to cluster.
    type: string
  color_scheme:
    default: rocket
    doc: The matplotlib colorscheme to generate the heatmap with.
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- heatmap
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
