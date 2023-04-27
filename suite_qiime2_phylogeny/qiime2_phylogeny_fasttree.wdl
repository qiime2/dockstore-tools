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

struct qiime2_phylogeny_fasttree_params {
    File alignment
    String n_threads
    String tree
}

task qiime2_phylogeny_fasttree {

    input {
        File alignment
        String n_threads = '1'
        String tree
    }

    qiime2_phylogeny_fasttree_params task_params = object {
        alignment: alignment,
        n_threads: n_threads,
        tree: tree
    }

    command {
        q2dataflow q2wdl run phylogeny fasttree ~{write_json(task_params)}
    }

    output {
        File tree_file = "~{tree}"
    }

}


workflow wkflw_qiime2_phylogeny_fasttree {
input {
        File alignment
        String n_threads = '1'
        String tree
    }

    call qiime2_phylogeny_fasttree {
        input: alignment=alignment, n_threads=n_threads, tree=tree
    }

}
