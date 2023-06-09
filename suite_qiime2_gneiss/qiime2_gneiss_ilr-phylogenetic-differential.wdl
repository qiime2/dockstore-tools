# 
# Copyright (c) 2023, QIIME 2 development team.
# 
# Distributed under the terms of the Modified BSD License. (SPDX: BSD-3-Clause)
# 
# 
# This tool was automatically generated by:
#     q2wdl (version: 0.1.0)
# for:
#     qiime2 (version: 2023.2.0)
# 


version 1.0

struct qiime2_gneiss_ilr_phylogenetic_differential_params {
    File differential
    File tree
    String ilr_differential
    String bifurcated_tree
}

task qiime2_gneiss_ilr_phylogenetic_differential {

    input {
        File differential
        File tree
        String ilr_differential
        String bifurcated_tree
    }

    qiime2_gneiss_ilr_phylogenetic_differential_params task_params = object {
        differential: differential,
        tree: tree,
        ilr_differential: ilr_differential,
        bifurcated_tree: bifurcated_tree
    }

    command {
        q2dataflow q2wdl run gneiss ilr_phylogenetic_differential ~{write_json(task_params)}
    }

    output {
        File ilr_differential_file = "~{ilr_differential}"
        File bifurcated_tree_file = "~{bifurcated_tree}"
    }

}


workflow wkflw_qiime2_gneiss_ilr_phylogenetic_differential {
input {
        File differential
        File tree
        String ilr_differential
        String bifurcated_tree
    }

    call qiime2_gneiss_ilr_phylogenetic_differential {
        input: differential=differential, tree=tree, ilr_differential=ilr_differential, bifurcated_tree=bifurcated_tree
    }

}
