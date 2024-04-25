#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_alpha_correlation
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Alpha diversity correlation
doc: Determine whether numeric sample metadata columns are correlated with alpha diversity.
inputs:
  alpha_diversity:
    doc: Vector of alpha diversity values by sample.
    type: File
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
  method:
    default: spearman
    doc: The correlation test to be applied.
    type: string
  intersect_ids:
    default: false
    doc: If supplied, IDs that are not found in both the alpha diversity vector and
      metadata will be discarded before calculating the correlation. Default behavior
      is to error on any mismatched IDs.
    type: boolean
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- alpha_correlation
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
