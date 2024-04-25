#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_filter_q_score
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Quality filter based on sequence quality scores.
doc: This method filters sequence based on quality scores and the presence of ambiguous
  base calls.
inputs:
  demux:
    doc: The demultiplexed sequence data to be quality filtered.
    type: File
  min_quality:
    default: 4
    doc: The minimum acceptable PHRED score. All PHRED scores less that this value
      are considered to be low PHRED scores.
    type: long
  quality_window:
    default: 3
    doc: The maximum number of low PHRED scores that can be observed in direct succession
      before truncating a sequence read.
    type: long
  min_length_fraction:
    default: 0.75
    doc: The minimum length that a sequence read can be following truncation and still
      be retained. This length should be provided as a fraction of the input sequence
      length.
    type: double
  max_ambiguous:
    default: 0
    doc: The maximum number of ambiguous (i.e., N) base calls. This is applied after
      trimming sequences based on `min_length_fraction`.
    type: long
  filtered_sequences:
    doc: The resulting quality-filtered sequences.
    type: string
  filter_stats:
    doc: Summary statistics of the filtering process.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_filter
- q_score
- inputs.json
outputs:
  filtered_sequences_file:
    doc: The resulting quality-filtered sequences.
    outputBinding:
      glob: $(inputs.filtered_sequences)
    type: File
  filter_stats_file:
    doc: Summary statistics of the filtering process.
    outputBinding:
      glob: $(inputs.filter_stats)
    type: File
