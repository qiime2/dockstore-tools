#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_align_to_tree_mafft_iqtree
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Build a phylogenetic tree using iqtree and mafft alignment.
doc: This pipeline will start by creating a sequence alignment using MAFFT, after
  which any alignment columns that are phylogenetically uninformative or ambiguously
  aligned will be removed (masked). The resulting masked alignment will be used to
  infer a phylogenetic tree using IQ-TREE. By default the best fit substitution model
  will be determined by ModelFinder prior to phylogenetic inference. The resulting
  tree will be subsequently rooted at its midpoint. Output files from each step of
  the pipeline will be saved. This includes both the unmasked and masked MAFFT alignment
  from q2-alignment methods, and both the rooted and unrooted phylogenies from q2-phylogeny
  methods.
inputs:
  sequences:
    doc: The sequences to be used for creating a iqtree based rooted phylogenetic
      tree.
    type: File
  n_threads:
    default: 1
    doc: The number of threads. (Use 0 to automatically use all available cores This
      value is used when aligning the sequences and creating the tree with iqtree.
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
  substitution_model:
    default: MFP
    doc: Model of Nucleotide Substitution. If not provided, IQ-TREE will determine
      the best fit substitution model automatically.
    type: string
  fast:
    default: false
    doc: Fast search to resemble FastTree.
    type: boolean
  alrt:
    doc: Single branch test method. Number of bootstrap replicates to perform an SH-like
      approximate likelihood ratio test (SH-aLRT). Minimum of 1000 replicates is required.
    type: long?
  seed:
    doc: Random number seed for the iqtree parsimony starting tree. This allows you
      to reproduce tree results. If not supplied then one will be randomly chosen.
    type: long?
  stop_iter:
    doc: Number of unsuccessful iterations to stop. If not set, program defaults will
      be used. See IQ-TREE manual for details.
    type: long?
  perturb_nni_strength:
    doc: Perturbation strength for randomized NNI. If not set, program defaults will
      be used. See IQ-TREE manual for details.
    type: double?
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
- align_to_tree_mafft_iqtree
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
