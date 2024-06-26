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

struct qiime2_diversity_lib_observed_features_params {
    File table
    String vector
}

task qiime2_diversity_lib_observed_features {

    input {
        File table
        String vector
    }

    qiime2_diversity_lib_observed_features_params task_params = object {
        table: table,
        vector: vector
    }

    command {
        q2dataflow wdl run diversity_lib observed_features ~{write_json(task_params)}
    }

    output {
        File vector_file = "~{vector}"
    }

}


workflow wkflw_qiime2_diversity_lib_observed_features {
input {
        File table
        String vector
    }

    call qiime2_diversity_lib_observed_features {
        input: table=table, vector=vector
    }

}
