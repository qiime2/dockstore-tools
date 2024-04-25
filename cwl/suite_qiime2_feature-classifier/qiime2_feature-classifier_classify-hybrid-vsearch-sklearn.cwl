#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_classify_hybrid_vsearch_sklearn
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: 'ALPHA Hybrid classifier: VSEARCH exact match + sklearn classifier'
doc: 'NOTE: THIS PIPELINE IS AN ALPHA RELEASE. Please report bugs to https://forum.qiime2.org!

  Assign taxonomy to query sequences using hybrid classifier. First performs rough
  positive filter to remove artifact and low-coverage sequences (use "prefilter" parameter
  to toggle this step on or off). Second, performs VSEARCH exact match between query
  and reference_reads to find exact matches, followed by least common ancestor consensus
  taxonomy assignment from among maxaccepts top hits, min_consensus of which share
  that taxonomic assignment. Query sequences without an exact match are then classified
  with a pre-trained sklearn taxonomy classifier to predict the most likely taxonomic
  lineage.'
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
  classifier:
    doc: Pre-trained sklearn taxonomic classifier for classifying the reads.
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
    default: 0.5
    doc: Percent sequence similarity to use for PREFILTER. Reject match if percent
      identity to query is lower. Set to a lower value to perform a rough pre-filter.
      This parameter is ignored if `prefilter` is disabled.
    type: double
  query_cov:
    default: 0.8
    doc: Query coverage threshold to use for PREFILTER. Reject match if query alignment
      coverage per high-scoring pair is lower. Set to a lower value to perform a rough
      pre-filter. This parameter is ignored if `prefilter` is disabled.
    type: double
  strand:
    default: both
    doc: Align against reference sequences in forward ("plus") or both directions
      ("both").
    type: string
  min_consensus:
    default: 0.51
    doc: Minimum fraction of assignments must match top hit to be accepted as consensus
      assignment.
    type: double
  maxhits:
    default: all
    doc: null
    type:
    - long
    - string
  maxrejects:
    default: all
    doc: null
    type:
    - long
    - string
  reads_per_batch:
    default: auto
    doc: Number of reads to process in each batch for sklearn classification. If "auto",
      this parameter is autoscaled to min(number of query sequences / threads, 20000).
    type:
    - long
    - string
  confidence:
    default: 0.7
    doc: Confidence threshold for limiting taxonomic depth. Set to "disable" to disable
      confidence calculation, or 0 to calculate confidence but not apply it to limit
      the taxonomic depth of the assignments.
    type:
    - double
    - string
  read_orientation:
    default: auto
    doc: Direction of reads with respect to reference sequences in pre-trained sklearn
      classifier. same will cause reads to be classified unchanged; reverse-complement
      will cause reads to be reversed and complemented prior to classification. "auto"
      will autodetect orientation based on the confidence estimates for the first
      100 reads.
    type: string
  threads:
    default: 1
    doc: Number of threads to use for job parallelization. Pass 0 to use one per available
      CPU.
    type: long
  prefilter:
    default: true
    doc: Toggle positive filter of query sequences on or off.
    type: boolean
  sample_size:
    default: 1000
    doc: Randomly extract the given number of sequences from the reference database
      to use for prefiltering. This parameter is ignored if `prefilter` is disabled.
    type: long
  randseed:
    default: 0
    doc: Use integer as a seed for the pseudo-random generator used during prefiltering.
      A given seed always produces the same output, which is useful for replicability.
      Set to 0 to use a pseudo-random seed. This parameter is ignored if `prefilter`
      is disabled.
    type: long
  classification:
    doc: Taxonomy classifications of query sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- classify_hybrid_vsearch_sklearn
- inputs.json
outputs:
  classification_file:
    doc: Taxonomy classifications of query sequences.
    outputBinding:
      glob: $(inputs.classification)
    type: File
