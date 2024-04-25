#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_evaluate_taxonomy
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Compute summary statistics on taxonomy artifact(s).
doc: 'Compute summary statistics on taxonomy artifact(s) and visualize as interactive
  lineplots. Summary statistics include the number of unique labels, taxonomic entropy,
  and the number of features that are (un)classified at each taxonomic level. This
  action is useful for both reference taxonomies and classification results. The x-axis
  in these plots represents the taxonomic levels present in the input taxonomies so
  are labeled numerically instead of by rank, but typically for 7-level taxonomies
  these will represent: 1 = domain/kingdom, 2 = phylum, 3 = class, 4 = order, 5 =
  family, 6 = genus, 7 = species.'
inputs:
  taxonomies:
    doc: One or more taxonomies to evaluate.
    type: File[]
  labels:
    doc: List of labels to use for labeling evaluation results in the resulting visualization.
      Inputs are labeled with labels in the order that each is input. If there are
      fewer labels than inputs (or no labels), unnamed inputs are labeled numerically
      in sequential order. Extra labels are ignored.
    type: string[]?
  rank_handle_regex:
    doc: 'Regular expression indicating which taxonomic rank a label belongs to; this
      handle is stripped from the label prior to operating on the taxonomy. The net
      effect is that ambiguous or empty levels can be removed prior to comparison,
      enabling selection of taxonomies with more complete taxonomic information. For
      example, "^[dkpcofgs]__" will recognize greengenes or silva rank handles. '
    type: string?
  taxonomy_stats:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- evaluate_taxonomy
- inputs.json
outputs:
  taxonomy_stats_file:
    doc: null
    outputBinding:
      glob: $(inputs.taxonomy_stats)
    type: File
