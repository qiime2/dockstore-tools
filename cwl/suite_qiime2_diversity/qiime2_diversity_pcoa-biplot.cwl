#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_pcoa_biplot
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Principal Coordinate Analysis Biplot
doc: Project features into a principal coordinates matrix. The features used should
  be the features used to compute the distance matrix. It is recommended that these
  variables be normalized in cases of dimensionally heterogeneous physical variables.
inputs:
  pcoa:
    doc: The PCoA where the features will be projected onto.
    type: File
  features:
    doc: Variables to project onto the PCoA matrix
    type: File
  biplot:
    doc: The resulting PCoA matrix.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- pcoa_biplot
- inputs.json
outputs:
  biplot_file:
    doc: The resulting PCoA matrix.
    outputBinding:
      glob: $(inputs.biplot)
    type: File
