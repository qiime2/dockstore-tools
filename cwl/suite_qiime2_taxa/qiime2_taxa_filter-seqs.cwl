#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_taxa_filter_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Taxonomy-based feature sequence filter.
doc: This method filters sequences based on their taxonomic annotations. Features
  can be retained in the result by specifying one or more include search terms, and
  can be filtered out of the result by specifying one or more exclude search terms.
  If both include and exclude are provided, the inclusion critera will be applied
  before the exclusion critera. Either include or exclude terms (or both) must be
  provided.
inputs:
  sequences:
    doc: Feature sequences to be filtered.
    type: File
  taxonomy:
    doc: Taxonomic annotations for features in the provided feature sequences. All
      features in the feature sequences must have a corresponding taxonomic annotation.
      Taxonomic annotations for features that are not present in the feature sequences
      will be ignored.
    type: File
  include:
    doc: One or more search terms that indicate which taxa should be included in the
      resulting sequences. If providing more than one term, terms should be delimited
      by the query-delimiter character. By default, all taxa will be included.
    type: string?
  exclude:
    doc: One or more search terms that indicate which taxa should be excluded from
      the resulting sequences. If providing more than one term, terms should be delimited
      by the query-delimiter character. By default, no taxa will be excluded.
    type: string?
  query_delimiter:
    default: ','
    doc: The string used to delimit multiple search terms provided to include or exclude.
      This parameter should only need to be modified if the default delimiter (a comma)
      is used in the provided taxonomic annotations.
    type: string
  mode:
    default: contains
    doc: Mode for determining if a search term matches a taxonomic annotation. "contains"
      requires that the annotation has the term as a substring; "exact" requires that
      the annotation is a perfect match to a search term.
    type: string
  filtered_sequences:
    doc: The taxonomy-filtered feature sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- taxa
- filter_seqs
- inputs.json
outputs:
  filtered_sequences_file:
    doc: The taxonomy-filtered feature sequences.
    outputBinding:
      glob: $(inputs.filtered_sequences)
    type: File
