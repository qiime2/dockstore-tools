# 
# Copyright (c) 2024, QIIME 2 development team.
# 
# Distributed under the terms of the Modified BSD License. (SPDX: BSD-3-Clause)
# 
# 
# This template was automatically generated by:
#     q2dataflow wdl (version: 0.2.0)
# for:
#     qiime2 (version: 2024.2.0)
# 


version 1.0

struct qiime2_diversity_beta_params {
    File table
    String metric
    Int pseudocount
    Int n_jobs
    String distance_matrix
}

task qiime2_diversity_beta {

    input {
        File table
        String metric
        Int pseudocount = 1
        Int n_jobs = 1
        String distance_matrix
    }

    qiime2_diversity_beta_params task_params = object {
        table: table,
        metric: metric,
        pseudocount: pseudocount,
        n_jobs: n_jobs,
        distance_matrix: distance_matrix
    }

    command {
        q2dataflow wdl run diversity beta ~{write_json(task_params)}
    }

    output {
        File distance_matrix_file = "~{distance_matrix}"
    }

}


workflow wkflw_qiime2_diversity_beta {
input {
        File table
        String metric
        Int pseudocount = 1
        Int n_jobs = 1
        String distance_matrix
    }

    call qiime2_diversity_beta {
        input: table=table, metric=metric, pseudocount=pseudocount, n_jobs=n_jobs, distance_matrix=distance_matrix
    }

}