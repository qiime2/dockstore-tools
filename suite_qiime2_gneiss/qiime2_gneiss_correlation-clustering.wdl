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

struct qiime2_gneiss_correlation_clustering_params {
    File table
    Float pseudocount
    String clustering
}

task qiime2_gneiss_correlation_clustering {

    input {
        File table
        Float pseudocount = 0.5
        String clustering
    }

    qiime2_gneiss_correlation_clustering_params task_params = object {
        table: table,
        pseudocount: pseudocount,
        clustering: clustering
    }

    command {
        q2dataflow q2wdl run gneiss correlation_clustering ~{write_json(task_params)}
    }

    output {
        File clustering_file = "~{clustering}"
    }

}


workflow wkflw_qiime2_gneiss_correlation_clustering {
input {
        File table
        Float pseudocount = 0.5
        String clustering
    }

    call qiime2_gneiss_correlation_clustering {
        input: table=table, pseudocount=pseudocount, clustering=clustering
    }

}
