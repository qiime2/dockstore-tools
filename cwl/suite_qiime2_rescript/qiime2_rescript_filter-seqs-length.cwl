#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_filter_seqs_length
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter sequences by length.
doc: Filter sequences by length with VSEARCH. For a combination of global and conditional
  taxonomic filtering, see filter_seqs_length_by_taxon.
inputs:
  sequences:
    doc: Sequences to be filtered by length.
    type: File
  global_min:
    doc: The minimum length threshold for filtering all sequences. Any sequence shorter
      than this length will be removed.
    type: long?
  global_max:
    doc: The maximum length threshold for filtering all sequences. Any sequence longer
      than this length will be removed.
    type: long?
  threads:
    default: 1
    doc: Number of computation threads to use (1 to 256). The number of threads should
      be lesser or equal to the number of available CPU cores.
    type: long
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
- filter_seqs_length
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
