#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_exclude_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Exclude sequences by alignment
doc: This method aligns feature sequences to a set of reference sequences to identify
  sequences that hit/miss the reference within a specified perc_identity, evalue,
  and perc_query_aligned. This method could be used to define a positive filter, e.g.,
  extract only feature sequences that align to a certain clade of bacteria; or to
  define a negative filter, e.g., identify sequences that align to contaminant or
  human DNA sequences that should be excluded from subsequent analyses. Note that
  filtering is performed based on the perc_identity, perc_query_aligned, and evalue
  thresholds (the latter only if method==BLAST and an evalue is set). Set perc_identity==0
  and/or perc_query_aligned==0 to disable these filtering thresholds as necessary.
inputs:
  query_sequences:
    doc: Sequences to test for exclusion
    type: File
  reference_sequences:
    doc: Reference sequences to align against feature sequences
    type: File
  method:
    default: blast
    doc: Alignment method to use for matching feature sequences against reference
      sequences
    type: string
  perc_identity:
    default: 0.97
    doc: Reject match if percent identity to reference is lower. Must be in range
      [0.0, 1.0]
    type: double
  evalue:
    doc: BLAST expectation (E) value threshold for saving hits. Reject if E value
      is higher than threshold. This threshold is disabled by default.
    type: double?
  perc_query_aligned:
    default: 0.97
    doc: Percent of query sequence that must align to reference in order to be accepted
      as a hit.
    type: double
  threads:
    default: 1
    doc: Number of threads to use. Only applies to vsearch method.
    type: long
  left_justify:
    default: false
    doc: Reject match if the pairwise alignment begins with gaps
    type: boolean
  sequence_hits:
    doc: Subset of feature sequences that align to reference sequences
    type: string
  sequence_misses:
    doc: Subset of feature sequences that do not align to reference sequences
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- exclude_seqs
- inputs.json
outputs:
  sequence_hits_file:
    doc: Subset of feature sequences that align to reference sequences
    outputBinding:
      glob: $(inputs.sequence_hits)
    type: File
  sequence_misses_file:
    doc: Subset of feature sequences that do not align to reference sequences
    outputBinding:
      glob: $(inputs.sequence_misses)
    type: File
