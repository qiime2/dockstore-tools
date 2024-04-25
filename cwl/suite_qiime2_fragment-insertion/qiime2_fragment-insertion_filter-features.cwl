#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_fragment_insertion_filter_features
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter fragments in tree from table.
doc: Filters fragments not inserted into a phylogenetic tree from a feature-table.
  Some fragments computed by e.g. Deblur or DADA2 are too remote to get inserted by
  SEPP into a reference phylogeny. To be able to use the feature-table for downstream
  analyses like computing Faith's PD or UniFrac, the feature-table must be cleared
  of fragments that are not part of the phylogenetic tree, because their path length
  can otherwise not be determined. Typically, the number of rejected fragments is
  low (<= 10), but it might be worth to inspect the ratio of reads assigned to those
  rejected fragments.
inputs:
  table:
    doc: A feature-table which needs to filtered down to those fragments that are
      contained in the tree, e.g. result of a Deblur or DADA2 run.
    type: File
  tree:
    doc: The tree resulting from inserting fragments into a reference phylogeny, i.e.
      the output of function 'sepp'
    type: File
  filtered_table:
    doc: The input table minus those fragments that were not part of the tree. This
      feature-table can be used for downstream analyses like phylogenetic alpha- or
      beta- diversity computation.
    type: string
  removed_table:
    doc: Those fragments that got removed from the input table, because they were
      not part of the tree. This table is mainly used for quality control, e.g. to
      inspect the ratio of removed reads per sample from the input table. You can
      ignore this table for downstream analyses.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- fragment_insertion
- filter_features
- inputs.json
outputs:
  filtered_table_file:
    doc: The input table minus those fragments that were not part of the tree. This
      feature-table can be used for downstream analyses like phylogenetic alpha- or
      beta- diversity computation.
    outputBinding:
      glob: $(inputs.filtered_table)
    type: File
  removed_table_file:
    doc: Those fragments that got removed from the input table, because they were
      not part of the tree. This table is mainly used for quality control, e.g. to
      inspect the ratio of removed reads per sample from the input table. You can
      ignore this table for downstream analyses.
    outputBinding:
      glob: $(inputs.removed_table)
    type: File
