#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_fragment_insertion_sepp
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Insert fragment sequences using SEPP into reference phylogenies.
doc: Perform fragment insertion of sequences using the SEPP algorithm.
inputs:
  representative_sequences:
    doc: The sequences to insert into the reference tree.
    type: File
  reference_database:
    doc: The reference database to insert the representative sequences into.
    type: File
  alignment_subset_size:
    default: 1000
    doc: Each placement subset is further broken into subsets of at most these many
      sequences and a separate HMM is trained on each subset.
    type: long
  placement_subset_size:
    default: 5000
    doc: 'The tree is divided into subsets such that each subset includes at most
      these many subsets. The placement step places the fragment on only one subset,
      determined based on alignment scores. Further reading: https://github.com/smirarab/sepp/blob/master/tutorial/sepp-tutorial.md#sample-datasets-default-parameters.'
    type: long
  threads:
    default: 1
    doc: The number of threads to use. Pass 0 to use one per available core.
    type: long
  debug:
    default: false
    doc: Collect additional run information to STDOUT for debugging. Temporary directories
      will not be removed if run fails.
    type: boolean
  tree:
    doc: The tree with inserted feature data.
    type: string
  placements:
    doc: Information about the feature placements within the reference tree.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- fragment_insertion
- sepp
- inputs.json
outputs:
  tree_file:
    doc: The tree with inserted feature data.
    outputBinding:
      glob: $(inputs.tree)
    type: File
  placements_file:
    doc: Information about the feature placements within the reference tree.
    outputBinding:
      glob: $(inputs.placements)
    type: File
