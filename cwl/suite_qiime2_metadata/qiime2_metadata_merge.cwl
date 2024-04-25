#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_metadata_merge
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Merge metadata
doc: 'Merge metadata that contains overlapping ids or overlapping columns, but not
  both overlapping ids and overlapping columns. The result will be the union (i.e.,
  outer join) of the ids and columns from the two metadata inputs.


  Attemping to merge metadata with both overlapping ids and overlapping columns will
  currently fail because we don''t resolve conflicting column values for a sample.
  Merging metadata with neither overlapping ids or overlapping columns is possible
  with this action.


  To merge more than two metadata objects, run this command multiple times, iteratively
  using the output of the previous run as one of the metadata inputs.


  The output, an ImmutableMetadata artifact, can be used anywhere that a metadata
  file can be used, or can be exported to a metadata tsv file in the typical format.'
inputs:
  q2cwl_metafile_metadata1:
    doc: First metadata file to merge.
    type:
    - File
    - File[]
  q2cwl_metafile_metadata2:
    doc: Second metadata file to merge.
    type:
    - File
    - File[]
  merged_metadata:
    doc: The merged metadata.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- metadata
- merge
- inputs.json
outputs:
  merged_metadata_file:
    doc: The merged metadata.
    outputBinding:
      glob: $(inputs.merged_metadata)
    type: File
