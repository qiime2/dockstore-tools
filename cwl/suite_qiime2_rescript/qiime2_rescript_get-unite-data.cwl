#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_get_unite_data
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Download and import UNITE reference data.
doc: 'Download and import ITS sequences and taxonomy from the UNITE database, given
  a version number and taxon_group, with the option to select a cluster_id and include
  singletons. Downloads data directly from UNITE''s PlutoF REST API. NOTE: THIS ACTION
  ACQUIRES DATA FROM UNITE, which is licensed under CC BY-SA 4.0. To learn more, please
  visit https://unite.ut.ee/cite.php and https://creativecommons.org/licenses/by-sa/4.0/.'
inputs:
  version:
    default: '9.0'
    doc: UNITE version to download.
    type: string
  taxon_group:
    default: eukaryotes
    doc: Download a database with only 'fungi' or including all 'eukaryotes'.
    type: string
  cluster_id:
    default: '99'
    doc: Percent similarity at which sequences in the of database were clustered.
    type: string
  singletons:
    default: false
    doc: Include singleton clusters in the database.
    type: boolean
  taxonomy:
    doc: UNITE reference taxonomy.
    type: string
  sequences:
    doc: UNITE reference sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- get_unite_data
- inputs.json
outputs:
  taxonomy_file:
    doc: UNITE reference taxonomy.
    outputBinding:
      glob: $(inputs.taxonomy)
    type: File
  sequences_file:
    doc: UNITE reference sequences.
    outputBinding:
      glob: $(inputs.sequences)
    type: File
