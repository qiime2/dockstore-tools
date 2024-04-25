#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_trim_alignment
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Trim alignment based on provided primers or specific positions.
doc: Trim an existing alignment based on provided primers or specific, pre-defined
  positions. Primers take precedence over the positions,i.e. if both are provided,
  positions will be ignored.When using primers in combination with a DNA alignment,
  a new alignment will be generated to locate primer positions. Subsequently, start
  (5'-most) and end (3'-most) position from fwd and rev primer located within the
  new alignment is identified and used for slicing the original alignment.
inputs:
  aligned_sequences:
    doc: Aligned DNA sequences.
    type: File
  primer_fwd:
    doc: Forward primer used to find the start position for alignment trimming.
    type: string?
  primer_rev:
    doc: Reverse primer used to find the end position for alignment trimming.
    type: string?
  position_start:
    doc: Position within the alignment where the trimming will begin. If not provided,
      alignment will notbe trimmed at the beginning. If forward primer isspecified
      this parameter will be ignored.
    type: long?
  position_end:
    doc: Position within the alignment where the trimming will end. If not provided,
      alignment will not be trimmed at the end. If reverse primer is specified this
      parameter will be ignored.
    type: long?
  trimmed_sequences:
    doc: Trimmed sequence alignment.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- trim_alignment
- inputs.json
outputs:
  trimmed_sequences_file:
    doc: Trimmed sequence alignment.
    outputBinding:
      glob: $(inputs.trimmed_sequences)
    type: File
