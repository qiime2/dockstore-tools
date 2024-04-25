#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_cull_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Removes sequences that contain at least the specified number of degenerate
  bases and/or homopolymers of a given length.
doc: Filter DNA or RNA sequences that contain ambiguous bases and homopolymers, and
  output filtered DNA sequences. Removes DNA sequences that have the specified number,
  or more, of IUPAC compliant degenerate bases. Remaining sequences are removed if
  they contain homopolymers equal to or longer than the specified length. If the input
  consists of RNA sequences, they are reverse transcribed to DNA before filtering.
inputs:
  sequences:
    doc: DNA or RNA Sequences to be screened for removal based on degenerate base
      and homopolymer screening criteria.
    type: File
  num_degenerates:
    default: 5
    doc: Sequences with N, or more, degenerate bases will be removed.
    type: long
  homopolymer_length:
    default: 8
    doc: Sequences containing a homopolymer sequence of length N, or greater, will
      be removed.
    type: long
  n_jobs:
    default: 1
    doc: Number of concurrent processes to use while processing sequences. More is
      faster but typically should not be higher than the number of available CPUs.
      Output sequence order may change when using multiple jobs.
    type: long
  clean_sequences:
    doc: The resulting DNA sequences that pass degenerate base and homopolymer screening
      criteria.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- cull_seqs
- inputs.json
outputs:
  clean_sequences_file:
    doc: The resulting DNA sequences that pass degenerate base and homopolymer screening
      criteria.
    outputBinding:
      glob: $(inputs.clean_sequences)
    type: File
