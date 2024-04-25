#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_iqtree
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Construct a phylogenetic tree with IQ-TREE.
doc: Construct a phylogenetic tree using IQ-TREE (http://www.iqtree.org/) with automatic
  model selection.
inputs:
  alignment:
    doc: Aligned sequences to be used for phylogenetic reconstruction.
    type: File
  seed:
    doc: Random number seed. If not set, program defaults will be used. See IQ-TREE
      manual for details.
    type: long?
  n_cores:
    default: 1
    doc: The number of cores to use for parallel processing. Use `auto` to let IQ-TREE
      automatically determine the optimal number of cores to use.
    type: long
  n_cores_max:
    doc: Limits the maximum number of cores to be used when 'n_cores' is set to 'auto'.
    type: long?
  n_runs:
    default: 1
    doc: Number of indepedent runs. Multiple  independent runs (e.g. 10) can outperform
      a single run in terms of likelihood maximisation.
    type: long
  substitution_model:
    default: MFP
    doc: Model of Nucleotide Substitution. If not provided, IQ-TREE will determine
      the best fit substitution model automatically.
    type: string
  n_init_pars_trees:
    doc: Number of initial parsimony trees. If not set, program defaults will be used.
      See IQ-TREE manual for details.
    type: long?
  n_top_init_trees:
    doc: Number of top initial trees. If not set, program defaults will be used. See
      IQ-TREE manual for details.
    type: long?
  n_best_retain_trees:
    doc: Number of best trees retained during search. If not set, program defaults
      will be used. See IQ-TREE manual for details.
    type: long?
  n_iter:
    doc: Fix number of iterations to stop. If not set, program defaults will be used.
      See IQ-TREE manual for details.
    type: long?
  stop_iter:
    doc: Number of unsuccessful iterations to stop. If not set, program defaults will
      be used. See IQ-TREE manual for details.
    type: long?
  perturb_nni_strength:
    doc: Perturbation strength for randomized NNI. If not set, program defaults will
      be used. See IQ-TREE manual for details.
    type: double?
  spr_radius:
    doc: Radius for parsimony SPR search. If not set, program defaults will be used.
      See IQ-TREE manual for details.
    type: long?
  allnni:
    default: false
    doc: Perform more thorough NNI search.
    type: boolean
  fast:
    default: false
    doc: Fast search to resemble FastTree.
    type: boolean
  alrt:
    doc: 'Single branch test method. Number of bootstrap replicates to perform an
      SH-like approximate likelihood ratio test (SH-aLRT). Minimum of 1000 replicates
      is required. Can be used with other ''single branch test methods''. Values reported
      in the order of: alrt, lbp, abayes.'
    type: long?
  abayes:
    default: false
    doc: 'Single branch test method. Approximate Bayes test. Can be used with other
      ''single branch test methods''. Values reported in the order of: alrt, lbp,
      abayes.'
    type: boolean
  lbp:
    doc: 'Single branch test method. Number of bootstrap replicates to perform a fast
      local bootstrap probability method. Minimum of 1000 replicates is required.
      Can be used with other ''single branch test methods''. Values reported in the
      order of: alrt, lbp, abayes.'
    type: long?
  safe:
    default: false
    doc: Safe likelihood kernel to avoid numerical underflow.
    type: boolean
  tree:
    doc: The resulting phylogenetic tree.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- phylogeny
- iqtree
- inputs.json
outputs:
  tree_file:
    doc: The resulting phylogenetic tree.
    outputBinding:
      glob: $(inputs.tree)
    type: File
