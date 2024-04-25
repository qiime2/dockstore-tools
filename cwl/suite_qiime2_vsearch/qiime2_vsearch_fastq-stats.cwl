#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_vsearch_fastq_stats
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Fastq stats with vsearch.
doc: A fastq overview via vsearch's fastq_stats, fastq_eestats and fastq_eestats2
  utilities. Please see https://github.com/torognes/vsearch for detailed documentation
  of these tools.
inputs:
  sequences:
    doc: Fastq sequences
    type: File
  threads:
    default: 1
    doc: The number of threads used for computation.
    type: long
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- vsearch
- fastq_stats
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
