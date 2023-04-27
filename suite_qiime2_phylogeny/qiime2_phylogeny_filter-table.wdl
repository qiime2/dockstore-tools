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

struct qiime2_phylogeny_filter_table_params {
    File table
    File tree
    String filtered_table
}

task qiime2_phylogeny_filter_table {

    input {
        File table
        File tree
        String filtered_table
    }

    qiime2_phylogeny_filter_table_params task_params = object {
        table: table,
        tree: tree,
        filtered_table: filtered_table
    }

    command {
        q2dataflow q2wdl run phylogeny filter_table ~{write_json(task_params)}
    }

    output {
        File filtered_table_file = "~{filtered_table}"
    }

}


workflow wkflw_qiime2_phylogeny_filter_table {
input {
        File table
        File tree
        String filtered_table
    }

    call qiime2_phylogeny_filter_table {
        input: table=table, tree=tree, filtered_table=filtered_table
    }

}
