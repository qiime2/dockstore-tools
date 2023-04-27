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

struct qiime2_diversity_lib_pielou_evenness_params {
    File table
    Boolean drop_undefined_samples
    String vector
}

task qiime2_diversity_lib_pielou_evenness {

    input {
        File table
        Boolean drop_undefined_samples = false
        String vector
    }

    qiime2_diversity_lib_pielou_evenness_params task_params = object {
        table: table,
        drop_undefined_samples: drop_undefined_samples,
        vector: vector
    }

    command {
        q2dataflow q2wdl run diversity_lib pielou_evenness ~{write_json(task_params)}
    }

    output {
        File vector_file = "~{vector}"
    }

}


workflow wkflw_qiime2_diversity_lib_pielou_evenness {
input {
        File table
        Boolean drop_undefined_samples = false
        String vector
    }

    call qiime2_diversity_lib_pielou_evenness {
        input: table=table, drop_undefined_samples=drop_undefined_samples, vector=vector
    }

}
