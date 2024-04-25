#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_align_to_tree_mafft_raxml
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Build a phylogenetic tree using raxml and mafft alignment.
doc: This pipeline will start by creating a sequence alignment using MAFFT, after
  which any alignment columns that are phylogenetically uninformative or ambiguously
  aligned will be removed (masked). The resulting masked alignment will be used to
  infer a phylogenetic tree using RAxML, under the specified substitution model, and
  then subsequently rooted at its midpoint. Output files from each step of the pipeline
  will be saved. This includes both the unmasked and masked MAFFT alignment from q2-alignment
  methods, and both the rooted and unrooted phylogenies from q2-phylogeny methods.
inputs:
  sequences:
    doc: The sequences to be used for creating a iqtree based rooted phylogenetic
      tree.
    type: File
  n_threads:
    default: 1
    doc: The number of threads. (Use `all` to automatically use all available cores.
      This value is used when aligning the sequences and creating the tree with iqtree.
    type: long
  mask_max_gap_frequency:
    default: 1.0
    doc: The maximum relative frequency of gap characters in a column for the column
      to be retained. This relative frequency must be a number between 0.0 and 1.0
      (inclusive), where 0.0 retains only those columns without gap characters, and
      1.0 retains all columns  regardless of gap character frequency. This value is
      used when masking the aligned sequences.
    type: double
  mask_min_conservation:
    default: 0.4
    doc: The minimum relative frequency of at least one non-gap character in a column
      for that column to be retained. This relative frequency must be a number between
      0.0 and 1.0 (inclusive). For example, if a value of  0.4 is provided, a column
      will only be retained  if it contains at least one character that is present
      in at least 40% of the sequences. This value is used when masking the aligned
      sequences.
    type: double
  parttree:
    default: false
    doc: 'This flag is required if the number of sequences being aligned are larger
      than 1000000. Disabled by default. NOTE: if using this option, it is recomended
      that only the CAT-based substitution models of RAxML be considered for this
      pipeline.'
    type: boolean
  substitution_model:
    default: GTRGAMMA
    doc: Model of Nucleotide Substitution.
    type: string
  seed:
    doc: Random number seed for the parsimony starting tree. This allows you to reproduce
      tree results. If not supplied then one will be randomly chosen.
    type: long?
  raxml_version:
    default: Standard
    doc: Select a specific CPU optimization of RAxML to use. The SSE3 versions will
      run approximately 40% faster than the standard version. The AVX2 version will
      run 10-30% faster than the SSE3 version.
    type: string
  alignment:
    doc: The aligned sequences.
    type: string
  masked_alignment:
    doc: The masked alignment.
    type: string
  tree:
    doc: The unrooted phylogenetic tree.
    type: string
  rooted_tree:
    doc: The rooted phylogenetic tree.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- phylogeny
- align_to_tree_mafft_raxml
- inputs.json
outputs:
  alignment_file:
    doc: The aligned sequences.
    outputBinding:
      glob: $(inputs.alignment)
    type: File
  masked_alignment_file:
    doc: The masked alignment.
    outputBinding:
      glob: $(inputs.masked_alignment)
    type: File
  tree_file:
    doc: The unrooted phylogenetic tree.
    outputBinding:
      glob: $(inputs.tree)
    type: File
  rooted_tree_file:
    doc: The rooted phylogenetic tree.
    outputBinding:
      glob: $(inputs.rooted_tree)
    type: File
