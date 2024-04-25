#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_taxa_barplot
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Visualize taxonomy with an interactive bar plot
doc: This visualizer produces an interactive barplot visualization of taxonomies.
  Interactive features include multi-level sorting, plot recoloring, sample relabeling,
  and SVG figure export.
inputs:
  table:
    doc: Feature table to visualize at various taxonomic levels.
    type: File
  taxonomy:
    doc: Taxonomic annotations for features in the provided feature table. All features
      in the feature table must have a corresponding taxonomic annotation. Taxonomic
      annotations that are not present in the feature table will be ignored. If no
      taxonomy is provided, the feature IDs will be used as labels.
    type: File?
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File?
    - File[]?
  level_delimiter:
    doc: Attempt to parse hierarchical taxonomic information from feature IDs by separating
      levels with this character. This parameter is ignored if a taxonomy is provided
      as input.
    type: string?
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- taxa
- barplot
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
