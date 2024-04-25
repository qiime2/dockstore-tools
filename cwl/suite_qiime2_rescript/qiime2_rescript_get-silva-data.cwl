#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_get_silva_data
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Download, parse, and import SILVA database.
doc: 'Download, parse, and import SILVA database files, given a version number and
  reference target. Downloads data directly from SILVA, parses the taxonomy files,
  and outputs ready-to-use sequence and taxonomy artifacts. REQUIRES STABLE INTERNET
  CONNECTION. NOTE: THIS ACTION ACQUIRES DATA FROM THE SILVA DATABASE. SEE https://www.arb-silva.de/silva-license-information/
  FOR MORE INFORMATION and be aware that earlier versions may be released under a
  different license.'
inputs:
  version:
    default: '138.1'
    doc: SILVA database version to download.
    type: string
  target:
    default: SSURef_NR99
    doc: Reference sequence target to download. SSURef = redundant small subunit reference.
      LSURef = redundant large subunit reference. SSURef_NR99 = non-redundant (clustered
      at 99% similarity) small subunit reference.
    type: string
  include_species_labels:
    default: false
    doc: 'Include species rank labels in taxonomy output. Note: species-labels may
      not be reliable in all cases.'
    type: boolean
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
  download_sequences:
    default: true
    doc: 'Toggle whether or not to download and import the SILVA reference sequences
      associated with the release. Skipping the sequences is useful if you only want
      to download and parse the taxonomy, e.g., a local copy of the sequences already
      exists or for testing purposes. NOTE: if this option is used, a `silva_sequences`
      output is still created, but contains no data.'
    type: boolean
  silva_sequences:
    doc: SILVA reference sequences.
    type: string
  silva_taxonomy:
    doc: SILVA reference taxonomy.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- get_silva_data
- inputs.json
outputs:
  silva_sequences_file:
    doc: SILVA reference sequences.
    outputBinding:
      glob: $(inputs.silva_sequences)
    type: File
  silva_taxonomy_file:
    doc: SILVA reference taxonomy.
    outputBinding:
      glob: $(inputs.silva_taxonomy)
    type: File
