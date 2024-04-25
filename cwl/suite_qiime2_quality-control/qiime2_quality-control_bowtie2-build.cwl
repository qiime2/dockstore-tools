#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_bowtie2_build
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Build bowtie2 index from reference sequences.
doc: Build bowtie2 index from reference sequences.
inputs:
  sequences:
    doc: Reference sequences used to build bowtie2 index.
    type: File
  n_threads:
    default: 1
    doc: Number of threads to launch.
    type: long
  database:
    doc: Bowtie2 index.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- bowtie2_build
- inputs.json
outputs:
  database_file:
    doc: Bowtie2 index.
    outputBinding:
      glob: $(inputs.database)
    type: File
