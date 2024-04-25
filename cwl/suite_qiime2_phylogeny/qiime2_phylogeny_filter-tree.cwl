#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_filter_tree
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Remove features from tree based on metadata
doc: Remove tips from a tree if their identifiers based on a set of provided identifiers.
inputs:
  tree:
    doc: Tree that should be filtered
    type: File
  table:
    doc: Feature table which contains the identifier that should be retained in the
      tree
    type: File?
  q2cwl_metafile_metadata:
    doc: Feature metadata to use with the 'where' statement or to select tips to be
      retained. Metadata objects could also include FeatureData[Sequence] data types,
      if, forinstance, you want to filter to match represenative sequencces.
    type:
    - File?
    - File[]?
  where:
    doc: SQLite WHERE clause specifying sample metadata criteria that must be met
      to be included in the filtered feature table. If not provided, all samples in
      `metadata` that are also in the feature table will be retained.
    type: string?
  filtered_tree:
    doc: The resulting phylogenetic tree.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- phylogeny
- filter_tree
- inputs.json
outputs:
  filtered_tree_file:
    doc: The resulting phylogenetic tree.
    outputBinding:
      glob: $(inputs.filtered_tree)
    type: File
