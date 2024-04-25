#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_alignment_mask
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Positional conservation and gap filtering.
doc: Mask (i.e., filter) unconserved and highly gapped columns from an alignment.
  Default min_conservation was chosen to reproduce the mask presented in Lane (1991).
inputs:
  alignment:
    doc: The alignment to be masked.
    type: File
  max_gap_frequency:
    default: 1.0
    doc: The maximum relative frequency of gap characters in a column for the column
      to be retained. This relative frequency must be a number between 0.0 and 1.0
      (inclusive), where 0.0 retains only those columns without gap characters, and
      1.0 retains all columns regardless of gap character frequency.
    type: double
  min_conservation:
    default: 0.4
    doc: The minimum relative frequency of at least one non-gap character in a column
      for that column to be retained. This relative frequency must be a number between
      0.0 and 1.0 (inclusive). For example, if a value of 0.4 is provided, a column
      will only be retained if it contains at least one character that is present
      in at least 40% of the sequences.
    type: double
  masked_alignment:
    doc: The masked alignment.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- alignment
- mask
- inputs.json
outputs:
  masked_alignment_file:
    doc: The masked alignment.
    outputBinding:
      glob: $(inputs.masked_alignment)
    type: File
