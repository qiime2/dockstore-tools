#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_get_gtdb_data
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Download, parse, and import SSU GTDB reference data.
doc: 'Download, parse, and import SSU GTDB files, given a version number. Downloads
  data directly from GTDB, parses the taxonomy files, and outputs ready-to-use sequence
  and taxonomy artifacts. REQUIRES STABLE INTERNET CONNECTION. NOTE: THIS ACTION ACQUIRES
  DATA FROM GTDB. SEE https://gtdb.ecogenomic.org/about FOR MORE INFORMATION and be
  aware that earlier versions may be released under a different license.'
inputs:
  version:
    default: '214.1'
    doc: GTDB database version to download.
    type: string
  domain:
    default: Both
    doc: SSU sequence and taxonomy data to download from a given microbial domain
      from GTDB. 'Both' will fetch both bacterial and archaeal data. 'Bacteria' will
      only fetch bacterial data. 'Archaea' will only fetch archaeal data. This only
      applies to 'db-type SpeciesReps'.
    type: string
  db_type:
    default: SpeciesReps
    doc: '''All'': All SSU data that pass the quality-control of GTDB, but are not
      clustered into representative species. ''SpeciesReps'': SSU gene sequences identified
      within the set of representative species. Note: if ''All'' is used, the ''domain''
      parameter will be ignored as GTDB does not maintain separate domain-level files
      for these non-clustered data.'
    type: string
  gtdb_taxonomy:
    doc: SSU GTDB reference taxonomy.
    type: string
  gtdb_sequences:
    doc: SSU GTDB reference sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- get_gtdb_data
- inputs.json
outputs:
  gtdb_taxonomy_file:
    doc: SSU GTDB reference taxonomy.
    outputBinding:
      glob: $(inputs.gtdb_taxonomy)
    type: File
  gtdb_sequences_file:
    doc: SSU GTDB reference sequences.
    outputBinding:
      glob: $(inputs.gtdb_sequences)
    type: File
