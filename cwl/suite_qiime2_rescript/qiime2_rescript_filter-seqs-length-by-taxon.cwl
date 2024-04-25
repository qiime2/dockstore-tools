#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_filter_seqs_length_by_taxon
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter sequences by length and taxonomic group.
doc: Filter sequences by length. Can filter both globally by minimum and/or maximum
  length, and set individual threshold for individual taxonomic groups (using the
  "labels" option). Note that filtering can be performed for multiple taxonomic groups
  simultaneously, and nested taxonomic filters can be applied (e.g., to apply a more
  stringent filter for a particular genus, but a less stringent filter for other members
  of the kingdom). For global length-based filtering without conditional taxonomic
  filtering, see filter_seqs_length.
inputs:
  sequences:
    doc: Sequences to be filtered by length.
    type: File
  taxonomy:
    doc: Taxonomic classifications of sequences to be filtered.
    type: File
  labels:
    doc: 'One or more taxonomic labels to use for conditional filtering. For example,
      use this option to set different min/max filter settings for individual phyla.
      Must input the same number of labels as min_lens and/or max_lens. If a sequence
      matches multiple taxonomic labels, this method will apply the most stringent
      threshold(s): the longest minimum length and/or the shortest maximum length
      that is associated with the matching labels.'
    type: string[]
  min_lens:
    doc: Minimum length thresholds to use for filtering sequences associated with
      each label. If any min_lens are specified, must have the same number of min_lens
      as labels. Sequences that contain this label in their taxonomy will be removed
      if they are less than the specified length.
    type: long[]?
  max_lens:
    doc: Maximum length thresholds to use for filtering sequences associated with
      each label. If any max_lens are specified, must have the same number of max_lens
      as labels. Sequences that contain this label in their taxonomy will be removed
      if they are more than the specified length.
    type: long[]?
  global_min:
    doc: The minimum length threshold for filtering all sequences. Any sequence shorter
      than this length will be removed.
    type: long?
  global_max:
    doc: The maximum length threshold for filtering all sequences. Any sequence longer
      than this length will be removed.
    type: long?
  filtered_seqs:
    doc: Sequences that pass the filtering thresholds.
    type: string
  discarded_seqs:
    doc: Sequences that fall outside the filtering thresholds.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- filter_seqs_length_by_taxon
- inputs.json
outputs:
  filtered_seqs_file:
    doc: Sequences that pass the filtering thresholds.
    outputBinding:
      glob: $(inputs.filtered_seqs)
    type: File
  discarded_seqs_file:
    doc: Sequences that fall outside the filtering thresholds.
    outputBinding:
      glob: $(inputs.discarded_seqs)
    type: File
