#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_parse_silva_taxonomy
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Generates a SILVA fixed-rank taxonomy.
doc: 'Parses several files from the SILVA reference database to produce a GreenGenes-like
  fixed rank taxonomy that is 6 or 7 ranks deep, depending on whether or not `include_species_labels`
  is applied. The generated ranks (and the rank handles used to label these ranks
  in the resulting taxonomy) are: domain (d__), phylum (p__), class (c__), order (o__),
  family (f__), genus (g__), and species (s__). NOTE: THIS ACTION ACQUIRES DATA FROM
  THE SILVA DATABASE. SEE https://www.arb-silva.de/silva-license-information/ FOR
  MORE INFORMATION and be aware that earlier versions may be released under a different
  license.'
inputs:
  taxonomy_tree:
    doc: 'SILVA hierarchical taxonomy tree. The SILVA release filename typically takes
      the form of: ''tax_slv_ssu_X.tre'', where ''X'' is the SILVA version number.'
    type: File
  taxonomy_map:
    doc: 'SILVA taxonomy map. This file contains a mapping of the sequence accessions
      to the numeric taxonomy identifiers and species label information. The SILVA
      release filename is typically in the form of: ''taxmap_slv_ssu_ref_X.txt'',
      or ''taxmap_slv_ssu_ref_nr_X.txt'' where ''X'' is the SILVA version number.'
    type: File
  taxonomy_ranks:
    doc: 'SILVA taxonomy file. This file contains the taxonomic rank information for
      each numeric taxonomy identifier and the taxonomy. The SILVA  filename typically
      takes the form of: ''tax_slv_ssu_X.txt'', where ''X'' is the SILVA version number.'
    type: File
  rank_propagation:
    default: true
    doc: 'If a rank has no taxonomy associated with it, the taxonomy from the upper-level
      rank of that lineage, will be propagated downward. For example, if we are missing
      the genus label for ''f__Pasteurellaceae; g__''then the ''f__'' rank will be
      propagated to become: ''f__Pasteurellaceae; g__Pasteurellaceae''.'
    type: boolean
  ranks:
    doc: 'List of taxonomic ranks for building a taxonomy from the SILVA Taxonomy
      database. Use ''include_species_labels'' to append the organism name as the
      species label. [default: ''domain'', ''phylum'', ''class'', ''order'', ''family'',
      ''genus'']'
    type: string[]?
  include_species_labels:
    default: false
    doc: 'Include species rank labels in taxonomy output. Note: species-labels may
      not be reliable in all cases.'
    type: boolean
  taxonomy:
    doc: The resulting fixed-rank formatted SILVA taxonomy.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- parse_silva_taxonomy
- inputs.json
outputs:
  taxonomy_file:
    doc: The resulting fixed-rank formatted SILVA taxonomy.
    outputBinding:
      glob: $(inputs.taxonomy)
    type: File
