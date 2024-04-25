#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_emperor_plot
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Visualize and Interact with Principal Coordinates Analysis Plots
doc: Generates an interactive ordination plot where the user can visually integrate
  sample metadata.
inputs:
  pcoa:
    doc: The principal coordinates matrix to be plotted.
    type: File
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
  custom_axes:
    doc: Numeric sample metadata columns that should be included as axes in the Emperor
      plot.
    type: string[]?
  ignore_missing_samples:
    default: false
    doc: 'This will suppress the error raised when the coordinates matrix contains
      samples that are not present in the metadata. Samples without metadata are included
      by setting all metadata values to: "This sample has no metadata". This flag
      is only applied if at least one sample is present in both the coordinates matrix
      and the metadata.'
    type: boolean
  ignore_pcoa_features:
    default: false
    doc: Biplot arrows cannot be visualized using this method. If you want to visualize
      biplot arrows use the `biplot` method. Enabling this setting will ignore any
      PCoA features that are present, otherwise, if PCoA features are detected an
      error will be raised.
    type: boolean
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- emperor
- plot
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
