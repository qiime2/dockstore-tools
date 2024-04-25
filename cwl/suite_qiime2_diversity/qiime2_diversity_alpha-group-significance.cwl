#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_alpha_group_significance
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Alpha diversity comparisons
doc: Visually and statistically compare groups of alpha diversity values.
inputs:
  alpha_diversity:
    doc: Vector of alpha diversity values by sample.
    type: File
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- alpha_group_significance
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
