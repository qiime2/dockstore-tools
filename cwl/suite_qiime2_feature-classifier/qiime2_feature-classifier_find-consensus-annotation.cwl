#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_find_consensus_annotation
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Find consensus among multiple annotations.
doc: Find consensus annotation for each query searched against a reference database,
  by finding the least common ancestor among one or more semicolon-delimited hierarchical
  annotations. Note that the annotation hierarchy is assumed to have an even number
  of ranks.
inputs:
  search_results:
    doc: Search results in BLAST6 output format
    type: File
  reference_taxonomy:
    doc: reference taxonomy labels.
    type: File
  min_consensus:
    default: 0.51
    doc: Minimum fraction of assignments must match top hit to be accepted as consensus
      assignment.
    type: double
  unassignable_label:
    default: Unassigned
    doc: Annotation given when no consensus is found.
    type: string
  consensus_taxonomy:
    doc: Consensus taxonomy and scores.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- find_consensus_annotation
- inputs.json
outputs:
  consensus_taxonomy_file:
    doc: Consensus taxonomy and scores.
    outputBinding:
      glob: $(inputs.consensus_taxonomy)
    type: File
