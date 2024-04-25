#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_degap_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Remove gaps from DNA sequence alignments.
doc: This method converts aligned DNA sequences to unaligned DNA sequences by removing
  gaps ("-") and missing data (".") characters from the sequences. Essentially, 'unaligning'
  the sequences.
inputs:
  aligned_sequences:
    doc: Aligned DNA Sequences to be degapped.
    type: File
  min_length:
    default: 1
    doc: Minimum length of sequence to be returned after degapping.
    type: long
  degapped_sequences:
    doc: The resulting unaligned (degapped) DNA sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- degap_seqs
- inputs.json
outputs:
  degapped_sequences_file:
    doc: The resulting unaligned (degapped) DNA sequences.
    outputBinding:
      glob: $(inputs.degapped_sequences)
    type: File
