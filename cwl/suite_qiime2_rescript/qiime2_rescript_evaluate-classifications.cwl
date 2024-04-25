#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_evaluate_classifications
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Interactively evaluate taxonomic classification accuracy.
doc: 'Evaluate taxonomic classification accuracy by comparing one or more sets of
  true taxonomic labels to the predicted taxonomies for the same set(s) of features.
  Output an interactive line plot of classification accuracy for each pair of expected/observed
  taxonomies. The x-axis in these plots represents the taxonomic levels present in
  the input taxonomies so are labeled numerically instead of by rank, but typically
  for 7-level taxonomies these will represent: 1 = domain/kingdom, 2 = phylum, 3 =
  class, 4 = order, 5 = family, 6 = genus, 7 = species.'
inputs:
  expected_taxonomies:
    doc: True taxonomic labels for one more more sets of features.
    type: File[]
  observed_taxonomies:
    doc: Predicted classifications of same sets of features, input in same order as
      expected_taxonomies.
    type: File[]
  labels:
    doc: List of labels to use for labeling evaluation results in the resulting visualization.
      Inputs are labeled with labels in the order that each is input. If there are
      fewer labels than inputs (or no labels), unnamed inputs are labeled numerically
      in sequential order. Extra labels are ignored.
    type: string[]?
  evaluation:
    doc: Visualization of classification accuracy results.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- evaluate_classifications
- inputs.json
outputs:
  evaluation_file:
    doc: Visualization of classification accuracy results.
    outputBinding:
      glob: $(inputs.evaluation)
    type: File
