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

struct qiime2_gneiss_ilr_hierarchical_params {
    File table
    File tree
    Float pseudocount
    String balances
}

task qiime2_gneiss_ilr_hierarchical {

    input {
        File table
        File tree
        Float pseudocount = 0.5
        String balances
    }

    qiime2_gneiss_ilr_hierarchical_params task_params = object {
        table: table,
        tree: tree,
        pseudocount: pseudocount,
        balances: balances
    }

    command {
        q2dataflow q2wdl run gneiss ilr_hierarchical ~{write_json(task_params)}
    }

    output {
        File balances_file = "~{balances}"
    }

}


workflow wkflw_qiime2_gneiss_ilr_hierarchical {
input {
        File table
        File tree
        Float pseudocount = 0.5
        String balances
    }

    call qiime2_gneiss_ilr_hierarchical {
        input: table=table, tree=tree, pseudocount=pseudocount, balances=balances
    }

}
