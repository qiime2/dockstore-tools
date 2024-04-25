#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_extract_seq_segments
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Use reference sequences to extract shorter matching sequence segments from
  longer sequences based on a user-defined 'perc-identity' value.
doc: This action provides the ability to extract a region, or segment, of sequence
  without the need to specify primer pairs. This is very useful in cases when one
  or more of the primer sequences are not present within the target sequences, which
  prevents extraction of the (amplicon) region through primer-pair searching. Here,
  VSEARCH is used to extract these segments based on a reference pool of sequences
  that only span the region of interest.
inputs:
  input_sequences:
    doc: Sequences from which matching shorter sequence segments (regions) can be
      extracted from. Sequences containing segments that match those from 'reference-segment-sequences'
      will have those segments extracted and written to file.
    type: File
  reference_segment_sequences:
    doc: Reference sequence segments that will be used to search for and extract matching
      segments from 'sequences'.
    type: File
  perc_identity:
    default: 0.7
    doc: The percent identity at which clustering should be performed. This parameter
      maps to vsearch's --id parameter.
    type: double
  min_seq_len:
    doc: Minimum length of sequence allowed for searching. Any sequence less than
      this will be discarded. If not set, default program settings will be used.
    type: long?
  threads:
    default: 1
    doc: Number of computation threads to use (1 to 256). The number of threads should
      be lesser or equal to the number of available CPU cores.
    type: long
  extracted_sequence_segments:
    doc: Extracted sequence segments from 'input-sequences' that succesfully aligned
      to 'reference-segment-sequences'.
    type: string
  unmatched_sequences:
    doc: Sequences in 'input-sequences' that did not have matching sequence segments
      within 'reference-segment-sequences'.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- extract_seq_segments
- inputs.json
outputs:
  extracted_sequence_segments_file:
    doc: Extracted sequence segments from 'input-sequences' that succesfully aligned
      to 'reference-segment-sequences'.
    outputBinding:
      glob: $(inputs.extracted_sequence_segments)
    type: File
  unmatched_sequences_file:
    doc: Sequences in 'input-sequences' that did not have matching sequence segments
      within 'reference-segment-sequences'.
    outputBinding:
      glob: $(inputs.unmatched_sequences)
    type: File
