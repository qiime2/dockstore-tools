#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_filter_distance_matrix
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter samples from a distance matrix.
doc: Filter samples from a distance matrix, retaining only the samples matching search
  criteria specified by `metadata` and `where` parameters (or retaining only the samples
  not matching that criteria, if `exclude_ids` is True). See the filtering tutorial
  on https://docs.qiime2.org for additional details.
inputs:
  distance_matrix:
    doc: Distance matrix to filter by sample.
    type: File
  q2cwl_metafile_metadata:
    doc: Sample metadata used with `where` parameter when selecting samples to retain,
      or with `exclude_ids` when selecting samples to discard.
    type:
    - File
    - File[]
  where:
    doc: SQLite WHERE clause specifying sample metadata criteria that must be met
      to be included in the filtered distance matrix. If not provided, all samples
      in `metadata` that are also in the input distance matrix will be retained.
    type: string?
  exclude_ids:
    default: false
    doc: If `True`, the samples selected by `metadata` or `where` parameters will
      be excluded from the filtered distance matrix instead of being retained.
    type: boolean
  filtered_distance_matrix:
    doc: Distance matrix filtered to include samples matching search criteria
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- filter_distance_matrix
- inputs.json
outputs:
  filtered_distance_matrix_file:
    doc: Distance matrix filtered to include samples matching search criteria
    outputBinding:
      glob: $(inputs.filtered_distance_matrix)
    type: File
