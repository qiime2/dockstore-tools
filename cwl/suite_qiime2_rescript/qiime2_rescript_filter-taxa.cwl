#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_filter_taxa
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter taxonomy by list of IDs or search criteria.
doc: Filter taxonomy by list of IDs or search criteria.
inputs:
  taxonomy:
    doc: Taxonomy to filter.
    type: File
  q2cwl_metafile_ids_to_keep:
    doc: List of IDs to keep (as Metadata). Selecting these IDs occurs after inclusion
      and exclusion filtering.
    type:
    - File?
    - File[]?
  include:
    doc: List of search terms. Taxa containing one or more of these terms will be
      retained. Inclusion filtering occurs prior to exclusion filtering and selecting
      `ids_to_keep`.
    type: string[]?
  exclude:
    doc: List of search terms. Taxa containing one or more of these terms will be
      excluded. Exclusion filtering occurs after inclusion filtering and prior to
      selecting `ids_to_keep`.
    type: string[]?
  filtered_taxonomy:
    doc: The filtered taxonomy.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- filter_taxa
- inputs.json
outputs:
  filtered_taxonomy_file:
    doc: The filtered taxonomy.
    outputBinding:
      glob: $(inputs.filtered_taxonomy)
    type: File
