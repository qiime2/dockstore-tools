#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_blast
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: BLAST+ local alignment search.
doc: Search for top hits in a reference database via local alignment between the query
  sequences and reference database sequences using BLAST+. Returns a report of the
  top M hits for each query (where M=maxaccepts).
inputs:
  query:
    doc: Query sequences.
    type: File
  reference_reads:
    doc: Reference sequences. Incompatible with blastdb.
    type: File?
  blastdb:
    doc: BLAST indexed database. Incompatible with reference_reads.
    type: File?
  maxaccepts:
    default: 10
    doc: 'Maximum number of hits to keep for each query. BLAST will choose the first
      N hits in the reference database that exceed perc_identity similarity to query.
      NOTE: the database is not sorted by similarity to query, so these are the first
      N hits that pass the threshold, not necessarily the top N hits.'
    type: long
  perc_identity:
    default: 0.8
    doc: Reject match if percent identity to query is lower.
    type: double
  query_cov:
    default: 0.8
    doc: 'Reject match if query alignment coverage per high-scoring pair is lower.
      Note: this uses blastn''s qcov_hsp_perc parameter, and may not behave identically
      to the query_cov parameter used by classify-consensus-vsearch.'
    type: double
  strand:
    default: both
    doc: Align against reference sequences in forward ("plus"), reverse ("minus"),
      or both directions ("both").
    type: string
  evalue:
    default: 0.001
    doc: BLAST expectation value (E) threshold for saving hits.
    type: double
  output_no_hits:
    default: true
    doc: 'Report both matching and non-matching queries. WARNING: always use the default
      setting for this option unless if you know what you are doing! If you set this
      option to False, your sequences and feature table will need to be filtered to
      exclude unclassified sequences, otherwise you may run into errors downstream
      from missing feature IDs. Set to FALSE to mirror default BLAST search.'
    type: boolean
  num_threads:
    default: 1
    doc: Number of threads (CPUs) to use in the BLAST search. Pass 0 to use all available
      CPUs.
    type: long
  search_results:
    doc: Top hits for each query.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- blast
- inputs.json
outputs:
  search_results_file:
    doc: Top hits for each query.
    outputBinding:
      glob: $(inputs.search_results)
    type: File
