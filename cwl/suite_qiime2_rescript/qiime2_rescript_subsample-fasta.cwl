#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_subsample_fasta
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Subsample an indicated number of sequences from a FASTA file.
doc: Subsample a set of sequences (either plain or aligned DNA)based on a fraction
  of original sequences.
inputs:
  sequences:
    doc: Sequences to subsample from.
    type: File
  subsample_size:
    default: 0.1
    doc: Size of the random sample as a fraction of the total count
    type: double
  random_seed:
    default: 1
    doc: Seed to be used for random sampling.
    type: long
  sample_sequences:
    doc: Sample of original sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- subsample_fasta
- inputs.json
outputs:
  sample_sequences_file:
    doc: Sample of original sequences.
    outputBinding:
      glob: $(inputs.sample_sequences)
    type: File
