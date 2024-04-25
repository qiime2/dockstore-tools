#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_heatmap
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Generate heatmap of important features.
doc: Generate a heatmap of important features. Features are filtered based on importance
  scores; samples are optionally grouped by sample metadata; and a heatmap is generated
  that displays (normalized) feature abundances per sample.
inputs:
  table:
    doc: Feature table containing all features that should be used for target prediction.
    type: File
  importance:
    doc: Feature importances.
    type: File
  q2cwl_metafile_sample_metadata:
    doc: Sample metadata column to use for sample labeling or grouping.
    type: File?
  sample_metadata:
    doc: Column name to use from 'sample_metadata' file
    type: string?
  q2cwl_metafile_feature_metadata:
    doc: Feature metadata (e.g., taxonomy) to use for labeling features in the heatmap.
    type: File?
  feature_metadata:
    doc: Column name to use from 'feature_metadata' file
    type: string?
  feature_count:
    default: 50
    doc: Filter feature table to include top N most important features. Set to zero
      to include all features.
    type: long
  importance_threshold:
    default: 0
    doc: Filter feature table to exclude any features with an importance score less
      than this threshold. Set to zero to include all features.
    type: double
  group_samples:
    default: false
    doc: Group samples by sample metadata.
    type: boolean
  normalize:
    default: true
    doc: Normalize the feature table by adding a psuedocount of 1 and then taking
      the log10 of the table.
    type: boolean
  missing_samples:
    default: ignore
    doc: How to handle missing samples in metadata. "error" will fail if missing samples
      are detected. "ignore" will cause the feature table and metadata to be filtered,
      so that only samples found in both files are retained.
    type: string
  metric:
    default: braycurtis
    doc: Metrics exposed by seaborn (see http://seaborn.pydata.org/generated/seaborn.clustermap.html#seaborn.clustermap
      for more detail).
    type: string
  method:
    default: average
    doc: Clustering methods exposed by seaborn (see http://seaborn.pydata.org/generated/seaborn.clustermap.html#seaborn.clustermap
      for more detail).
    type: string
  cluster:
    default: features
    doc: Specify which axes to cluster.
    type: string
  color_scheme:
    default: rocket
    doc: Color scheme for heatmap.
    type: string
  heatmap:
    doc: Heatmap of important features.
    type: string
  filtered_table:
    doc: Filtered feature table containing data displayed in heatmap.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- heatmap
- inputs.json
outputs:
  heatmap_file:
    doc: Heatmap of important features.
    outputBinding:
      glob: $(inputs.heatmap)
    type: File
  filtered_table_file:
    doc: Filtered feature table containing data displayed in heatmap.
    outputBinding:
      glob: $(inputs.filtered_table)
    type: File
