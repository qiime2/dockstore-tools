#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_demux_filter_samples
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter samples out of demultiplexed data.
doc: Filter samples indicated in given metadata out of demultiplexed data. Specific
  samples can be further selected with the WHERE clause, and the `exclude_ids` parameter
  allows for filtering of all samples not specified.
inputs:
  demux:
    doc: The demultiplexed data from which samples should be filtered.
    type: File
  q2cwl_metafile_metadata:
    doc: Sample metadata indicating which sample ids to filter. The optional `where`
      parameter may be used to filter ids based on specified conditions in the metadata.
      The optional `exclude_ids` parameter may be used to exclude the ids specified
      in the metadata from the filter.
    type:
    - File
    - File[]
  where:
    doc: Optional SQLite WHERE clause specifying sample metadata criteria that must
      be met to be included in the filtered data. If not provided, all samples in
      `metadata` that are also in the demultiplexed data will be retained.
    type: string?
  exclude_ids:
    default: false
    doc: Defaults to False. If True, the samples selected by the `metadata` and optional
      `where` parameter will be excluded from the filtered data.
    type: boolean
  filtered_demux:
    doc: Filtered demultiplexed data.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- demux
- filter_samples
- inputs.json
outputs:
  filtered_demux_file:
    doc: Filtered demultiplexed data.
    outputBinding:
      glob: $(inputs.filtered_demux)
    type: File
