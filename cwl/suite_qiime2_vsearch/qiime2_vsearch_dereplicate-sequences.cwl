#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_vsearch_dereplicate_sequences
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Dereplicate sequences.
doc: Dereplicate sequence data and create a feature table and feature representative
  sequences. Feature identifiers in the resulting artifacts will be the sha1 hash
  of the sequence defining each feature. If clustering of features into OTUs is desired,
  the resulting artifacts can be passed to the cluster_features_* methods in this
  plugin.
inputs:
  sequences:
    doc: The sequences to be dereplicated.
    type: File
  derep_prefix:
    default: false
    doc: Merge sequences with identical prefixes. If a sequence is identical to the
      prefix of two or more longer sequences, it is clustered with the shortest of
      them. If they are equally long, it is clustered with the most abundant.
    type: boolean
  min_seq_length:
    default: 1
    doc: Discard sequences shorter than this integer.
    type: long
  min_unique_size:
    default: 1
    doc: Discard sequences with a post-dereplication abundance value smaller than
      integer.
    type: long
  dereplicated_table:
    doc: The table of dereplicated sequences.
    type: string
  dereplicated_sequences:
    doc: The dereplicated sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- vsearch
- dereplicate_sequences
- inputs.json
outputs:
  dereplicated_table_file:
    doc: The table of dereplicated sequences.
    outputBinding:
      glob: $(inputs.dereplicated_table)
    type: File
  dereplicated_sequences_file:
    doc: The dereplicated sequences.
    outputBinding:
      glob: $(inputs.dereplicated_sequences)
    type: File
