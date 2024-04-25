#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_fragment_insertion_classify_otus_experimental
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: 'Experimental: Obtain taxonomic lineages, by finding closest OTU in reference
  phylogeny.'
doc: 'Experimental: Use the resulting tree from ''sepp'' and find closest OTU-ID for
  every inserted fragment. Then, look up the reference lineage string in the reference
  taxonomy.'
inputs:
  representative_sequences:
    doc: The sequences used for a 'sepp' run to produce the 'tree'.
    type: File
  tree:
    doc: The tree resulting from inserting fragments into a reference phylogeny, i.e.
      the output of function 'sepp'
    type: File
  reference_taxonomy:
    doc: Reference taxonomic table that maps every OTU-ID into a taxonomic lineage
      string.
    type: File
  classification:
    doc: Taxonomic lineages for inserted fragments.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- fragment_insertion
- classify_otus_experimental
- inputs.json
outputs:
  classification_file:
    doc: Taxonomic lineages for inserted fragments.
    outputBinding:
      glob: $(inputs.classification)
    type: File
