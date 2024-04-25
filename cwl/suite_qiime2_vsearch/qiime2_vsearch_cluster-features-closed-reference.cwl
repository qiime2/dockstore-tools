#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_vsearch_cluster_features_closed_reference
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Closed-reference clustering of features.
doc: Given a feature table and the associated feature sequences, cluster the features
  against a reference database based on user-specified percent identity threshold
  of their sequences. This is not a general-purpose closed-reference clustering method,
  but rather is intended to be used for clustering the results of quality-filtering/dereplication
  methods, such as DADA2, or for re-clustering a FeatureTable at a lower percent identity
  than it was originally clustered at. When a group of features in the input table
  are clustered into a single feature, the frequency of that single feature in a given
  sample is the sum of the frequencies of the features that were clustered in that
  sample. Feature identifiers will be inherited from the centroid feature of each
  cluster. See the vsearch documentation for details on how sequence clustering is
  performed.
inputs:
  sequences:
    doc: The sequences corresponding to the features in table.
    type: File
  table:
    doc: The feature table to be clustered.
    type: File
  reference_sequences:
    doc: The sequences to use as cluster centroids.
    type: File
  perc_identity:
    doc: The percent identity at which clustering should be performed. This parameter
      maps to vsearch's --id parameter.
    type: double
  strand:
    default: plus
    doc: Search plus (i.e., forward) or both (i.e., forward and reverse complement)
      strands.
    type: string
  threads:
    default: 1
    doc: The number of threads to use for computation. Passing 0 will launch one thread
      per CPU core.
    type: long
  clustered_table:
    doc: The table following clustering of features.
    type: string
  clustered_sequences:
    doc: The sequences representing clustered features, relabeled by the reference
      IDs.
    type: string
  unmatched_sequences:
    doc: The sequences which failed to match any reference sequences. This output
      maps to vsearch's --notmatched parameter.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- vsearch
- cluster_features_closed_reference
- inputs.json
outputs:
  clustered_table_file:
    doc: The table following clustering of features.
    outputBinding:
      glob: $(inputs.clustered_table)
    type: File
  clustered_sequences_file:
    doc: The sequences representing clustered features, relabeled by the reference
      IDs.
    outputBinding:
      glob: $(inputs.clustered_sequences)
    type: File
  unmatched_sequences_file:
    doc: The sequences which failed to match any reference sequences. This output
      maps to vsearch's --notmatched parameter.
    outputBinding:
      glob: $(inputs.unmatched_sequences)
    type: File
