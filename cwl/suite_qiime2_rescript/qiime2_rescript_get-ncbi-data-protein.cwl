#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_get_ncbi_data_protein
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Download, parse, and import NCBI protein sequences and taxonomies
doc: 'Download and import sequences from the NCBI Protein database and download, parse,
  and import the corresponding taxonomies from the NCBI Taxonomy database.


  Please be aware of the NCBI Disclaimer and Copyright notice (https://www.ncbi.nlm.nih.gov/home/about/policies/),
  particularly "run retrieval scripts on weekends or between 9 pm and 5 am Eastern
  Time weekdays for any series of more than 100 requests". As a rough guide, if you
  are downloading more than 125,000 sequences, only run this method at those times.


  The NCBI servers can be capricious but reward polite persistence. If the download
  fails and gives you a message that contains the words "Last exception was ReadTimeout",
  you should probably try again, maybe with more connections. If it fails for any
  other reason, please create an issue at https://github.com/bokulich-lab/RESCRIPt.'
inputs:
  query:
    doc: Query on the NCBI Protein database
    type: string?
  q2cwl_metafile_accession_ids:
    doc: List of accession ids for sequences in the NCBI Protein database.
    type:
    - File?
    - File[]?
  ranks:
    doc: 'List of taxonomic ranks for building a taxonomy from the NCBI Taxonomy database.
      [default: ''kingdom'', ''phylum'', ''class'', ''order'', ''family'', ''genus'',
      ''species'']'
    type: string[]?
  rank_propagation:
    default: true
    doc: Propagate known ranks to missing ranks if true
    type: boolean
  logging_level:
    doc: Logging level, set to INFO for download progress or DEBUG for copious verbosity
    type: string?
  n_jobs:
    default: 1
    doc: Number of concurrent download connections. More is faster until you run out
      of bandwidth.
    type: long
  sequences:
    doc: Sequences from the NCBI Protein database
    type: string
  taxonomy:
    doc: Taxonomies from the NCBI Taxonomy database
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- get_ncbi_data_protein
- inputs.json
outputs:
  sequences_file:
    doc: Sequences from the NCBI Protein database
    outputBinding:
      glob: $(inputs.sequences)
    type: File
  taxonomy_file:
    doc: Taxonomies from the NCBI Taxonomy database
    outputBinding:
      glob: $(inputs.taxonomy)
    type: File
