#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_vsearch_cluster_features_de_novo
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: De novo clustering of features.
doc: Given a feature table and the associated feature sequences, cluster the features
  based on user-specified percent identity threshold of their sequences. This is not
  a general-purpose de novo clustering method, but rather is intended to be used for
  clustering the results of quality-filtering/dereplication methods, such as DADA2,
  or for re-clustering a FeatureTable at a lower percent identity than it was originally
  clustered at. When a group of features in the input table are clustered into a single
  feature, the frequency of that single feature in a given sample is the sum of the
  frequencies of the features that were clustered in that sample. Feature identifiers
  and sequences will be inherited from the centroid feature of each cluster. See the
  vsearch documentation for details on how sequence clustering is performed.
inputs:
  sequences:
    doc: The sequences corresponding to the features in table.
    type: File
  table:
    doc: The feature table to be clustered.
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
    doc: Sequences representing clustered features.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- vsearch
- cluster_features_de_novo
- inputs.json
outputs:
  clustered_table_file:
    doc: The table following clustering of features.
    outputBinding:
      glob: $(inputs.clustered_table)
    type: File
  clustered_sequences_file:
    doc: Sequences representing clustered features.
    outputBinding:
      glob: $(inputs.clustered_sequences)
    type: File
