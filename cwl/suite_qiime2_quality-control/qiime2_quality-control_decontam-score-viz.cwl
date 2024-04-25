#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_decontam_score_viz
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Generate a histogram representation of the scores
doc: Creates histogram based on the output of decontam identify
inputs:
  decontam_scores:
    doc: Output from decontam identify to be visualized
    type: Directory
  table:
    doc: Raw OTU/ASV table that was used as input to decontam-identify
    type: Directory
  threshold:
    default: 0.1
    doc: Select threshold cutoff for decontam algorithm scores
    type: double
  weighted:
    default: true
    doc: weight the decontam scores by their associated read number
    type: boolean
  bin_size:
    default: 0.02
    doc: Select bin size for the histogram
    type: double
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- decontam_score_viz
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
