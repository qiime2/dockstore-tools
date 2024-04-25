#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_reverse_transcribe
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Reverse transcribe RNA to DNA sequences.
doc: Reverse transcribe RNA to DNA sequences. Accepts aligned or unaligned RNA sequences
  as input.
inputs:
  rna_sequences:
    doc: RNA Sequences to reverse transcribe to DNA.
    type: File
  dna_sequences:
    doc: Reverse-transcribed DNA sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- reverse_transcribe
- inputs.json
outputs:
  dna_sequences_file:
    doc: Reverse-transcribed DNA sequences.
    outputBinding:
      glob: $(inputs.dna_sequences)
    type: File
