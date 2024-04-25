#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_classify_consensus_vsearch
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: VSEARCH-based consensus taxonomy classifier
doc: Assign taxonomy to query sequences using VSEARCH. Performs VSEARCH global alignment
  between query and reference_reads, then assigns consensus taxonomy to each query
  sequence from among maxaccepts top hits, min_consensus of which share that taxonomic
  assignment. Unlike classify-consensus-blast, this method searches the entire reference
  database before choosing the top N hits, not the first N hits.
inputs:
  query:
    doc: Query Sequences.
    type: File
  reference_reads:
    doc: Reference sequences.
    type: File
  reference_taxonomy:
    doc: Reference taxonomy labels.
    type: File
  maxaccepts:
    default: 10
    doc: Maximum number of hits to keep for each query. Set to "all" to keep all hits
      > perc_identity similarity. Note that if strand=both, maxaccepts will keep N
      hits for each direction (if searches in the opposite direction yield results
      that exceed the minimum perc_identity). In those cases use maxhits to control
      the total number of hits returned. This option works in pair with maxrejects.
      The search process sorts target sequences by decreasing number of k-mers they
      have in common with the query sequence, using that information as a proxy for
      sequence similarity. After pairwise alignments, if the first target sequence
      passes the acceptation criteria, it is accepted as best hit and the search process
      stops for that query. If maxaccepts is set to a higher value, more hits are
      accepted. If maxaccepts and maxrejects are both set to "all", the complete database
      is searched.
    type:
    - long
    - string
  perc_identity:
    default: 0.8
    doc: Reject match if percent identity to query is lower.
    type: double
  query_cov:
    default: 0.8
    doc: Reject match if query alignment coverage per high-scoring pair is lower.
    type: double
  strand:
    default: both
    doc: Align against reference sequences in forward ("plus") or both directions
      ("both").
    type: string
  search_exact:
    default: false
    doc: 'Search for exact full-length matches to the query sequences. Only 100% exact
      matches are reported and this command is much faster than the default. If True,
      the perc_identity, query_cov, maxaccepts, and maxrejects settings are ignored.
      Note: query and reference reads must be trimmed to the exact same DNA locus
      (e.g., primer site) because only exact matches will be reported.'
    type: boolean
  top_hits_only:
    default: false
    doc: Only the top hits between the query and reference sequence sets are reported.
      For each query, the top hit is the one presenting the highest percentage of
      identity. Multiple equally scored top hits will be used for consensus taxonomic
      assignment if maxaccepts is greater than 1.
    type: boolean
  maxhits:
    default: all
    doc: Maximum number of hits to show once the search is terminated.
    type:
    - long
    - string
  maxrejects:
    default: all
    doc: Maximum number of non-matching target sequences to consider before stopping
      the search. This option works in pair with maxaccepts (see maxaccepts description
      for details).
    type:
    - long
    - string
  output_no_hits:
    default: true
    doc: 'Report both matching and non-matching queries. WARNING: always use the default
      setting for this option unless if you know what you are doing! If you set this
      option to False, your sequences and feature table will need to be filtered to
      exclude unclassified sequences, otherwise you may run into errors downstream
      from missing feature IDs.'
    type: boolean
  weak_id:
    default: 0.0
    doc: Show hits with percentage of identity of at least N, without terminating
      the search. A normal search stops as soon as enough hits are found (as defined
      by maxaccepts, maxrejects, and perc_identity). As weak_id reports weak hits
      that are not deduced from maxaccepts, high perc_identity values can be used,
      hence preserving both speed and sensitivity. Logically, weak_id must be smaller
      than the value indicated by perc_identity, otherwise this option will be ignored.
    type: double
  threads:
    default: 1
    doc: Number of threads to use for job parallelization. Pass 0 to use one per available
      CPU.
    type: long
  min_consensus:
    default: 0.51
    doc: Minimum fraction of assignments must match top hit to be accepted as consensus
      assignment.
    type: double
  unassignable_label:
    default: Unassigned
    doc: Annotation given to sequences without any hits.
    type: string
  classification:
    doc: Taxonomy classifications of query sequences.
    type: string
  search_results:
    doc: Top hits for each query.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- classify_consensus_vsearch
- inputs.json
outputs:
  classification_file:
    doc: Taxonomy classifications of query sequences.
    outputBinding:
      glob: $(inputs.classification)
    type: File
  search_results_file:
    doc: Top hits for each query.
    outputBinding:
      glob: $(inputs.search_results)
    type: File
