#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_core_metrics
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Core diversity metrics (non-phylogenetic)
doc: Applies a collection of diversity metrics (non-phylogenetic) to a feature table.
inputs:
  table:
    doc: The feature table containing the samples over which diversity metrics should
      be computed.
    type: File
  sampling_depth:
    doc: The total frequency that each sample should be rarefied to prior to computing
      diversity metrics.
    type: long
  q2cwl_metafile_metadata:
    doc: The sample metadata to use in the emperor plots.
    type:
    - File
    - File[]
  with_replacement:
    default: false
    doc: Rarefy with replacement by sampling from the multinomial distribution instead
      of rarefying without replacement.
    type: boolean
  n_jobs:
    default: 1
    doc: '[beta methods only] - The number of concurrent jobs to use in performing
      this calculation. May not exceed the number of available physical cores. If
      n_jobs = ''auto'', one job will be launched for each identified CPU core on
      the host.'
    type: long
  ignore_missing_samples:
    default: false
    doc: 'If set to `True` samples and features without metadata are included by setting
      all metadata values to: "This element has no metadata". By default an exception
      will be raised if missing elements are encountered. Note, this flag only takes
      effect if there is at least one overlapping element.'
    type: boolean
  rarefied_table:
    doc: The resulting rarefied feature table.
    type: string
  observed_features_vector:
    doc: Vector of Observed Features values by sample.
    type: string
  shannon_vector:
    doc: Vector of Shannon diversity values by sample.
    type: string
  evenness_vector:
    doc: Vector of Pielou's evenness values by sample.
    type: string
  jaccard_distance_matrix:
    doc: Matrix of Jaccard distances between pairs of samples.
    type: string
  bray_curtis_distance_matrix:
    doc: Matrix of Bray-Curtis distances between pairs of samples.
    type: string
  jaccard_pcoa_results:
    doc: PCoA matrix computed from Jaccard distances between samples.
    type: string
  bray_curtis_pcoa_results:
    doc: PCoA matrix computed from Bray-Curtis distances between samples.
    type: string
  jaccard_emperor:
    doc: Emperor plot of the PCoA matrix computed from Jaccard.
    type: string
  bray_curtis_emperor:
    doc: Emperor plot of the PCoA matrix computed from Bray-Curtis.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- core_metrics
- inputs.json
outputs:
  rarefied_table_file:
    doc: The resulting rarefied feature table.
    outputBinding:
      glob: $(inputs.rarefied_table)
    type: File
  observed_features_vector_file:
    doc: Vector of Observed Features values by sample.
    outputBinding:
      glob: $(inputs.observed_features_vector)
    type: File
  shannon_vector_file:
    doc: Vector of Shannon diversity values by sample.
    outputBinding:
      glob: $(inputs.shannon_vector)
    type: File
  evenness_vector_file:
    doc: Vector of Pielou's evenness values by sample.
    outputBinding:
      glob: $(inputs.evenness_vector)
    type: File
  jaccard_distance_matrix_file:
    doc: Matrix of Jaccard distances between pairs of samples.
    outputBinding:
      glob: $(inputs.jaccard_distance_matrix)
    type: File
  bray_curtis_distance_matrix_file:
    doc: Matrix of Bray-Curtis distances between pairs of samples.
    outputBinding:
      glob: $(inputs.bray_curtis_distance_matrix)
    type: File
  jaccard_pcoa_results_file:
    doc: PCoA matrix computed from Jaccard distances between samples.
    outputBinding:
      glob: $(inputs.jaccard_pcoa_results)
    type: File
  bray_curtis_pcoa_results_file:
    doc: PCoA matrix computed from Bray-Curtis distances between samples.
    outputBinding:
      glob: $(inputs.bray_curtis_pcoa_results)
    type: File
  jaccard_emperor_file:
    doc: Emperor plot of the PCoA matrix computed from Jaccard.
    outputBinding:
      glob: $(inputs.jaccard_emperor)
    type: File
  bray_curtis_emperor_file:
    doc: Emperor plot of the PCoA matrix computed from Bray-Curtis.
    outputBinding:
      glob: $(inputs.bray_curtis_emperor)
    type: File
