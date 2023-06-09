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

struct qiime2_feature_table_subsample_params {
    File table
    Int subsampling_depth
    String axis
    String sampled_table
}

task qiime2_feature_table_subsample {

    input {
        File table
        Int subsampling_depth
        String axis
        String sampled_table
    }

    qiime2_feature_table_subsample_params task_params = object {
        table: table,
        subsampling_depth: subsampling_depth,
        axis: axis,
        sampled_table: sampled_table
    }

    command {
        q2dataflow q2wdl run feature_table subsample ~{write_json(task_params)}
    }

    output {
        File sampled_table_file = "~{sampled_table}"
    }

}


workflow wkflw_qiime2_feature_table_subsample {
input {
        File table
        Int subsampling_depth
        String axis
        String sampled_table
    }

    call qiime2_feature_table_subsample {
        input: table=table, subsampling_depth=subsampling_depth, axis=axis, sampled_table=sampled_table
    }

}
