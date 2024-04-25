#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_summarize_plus
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Summarize table plus
doc: Generate visual and tabular summaries of a feature table. Tabulate sample and
  feature frequencies.
inputs:
  table:
    doc: The feature table to be summarized.
    type: File
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File?
    - File[]?
  feature_frequencies:
    doc: Per-sample and total frequencies per feature.
    type: string
  sample_frequencies:
    doc: Observed feature count and total frequencies per sample.
    type: string
  summary:
    doc: Visual summary of feature table
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- summarize_plus
- inputs.json
outputs:
  feature_frequencies_file:
    doc: Per-sample and total frequencies per feature.
    outputBinding:
      glob: $(inputs.feature_frequencies)
    type: File
  sample_frequencies_file:
    doc: Observed feature count and total frequencies per sample.
    outputBinding:
      glob: $(inputs.sample_frequencies)
    type: File
  summary_file:
    doc: Visual summary of feature table
    outputBinding:
      glob: $(inputs.summary)
    type: File
