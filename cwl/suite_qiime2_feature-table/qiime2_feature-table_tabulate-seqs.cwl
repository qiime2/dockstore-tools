#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_tabulate_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: View sequence associated with each feature
doc: Generate tabular view of feature identifier to sequence mapping, including links
  to BLAST each sequence against the NCBI nt database.
inputs:
  data:
    doc: The feature sequences to be tabulated.
    type: File
  taxonomy:
    doc: The taxonomic classifications of the tabulated features.
    type: Directory?
  q2cwl_metafile_metadata:
    doc: Any additional metadata for the tabulated features.
    type:
    - File?
    - File[]?
  merge_method:
    default: strict
    doc: Method that joins data sets
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- tabulate_seqs
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
