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

struct qiime2_feature_table_subsample_ids_params {
    File table
    Int subsampling_depth
    String axis
    String sampled_table
}

task qiime2_feature_table_subsample_ids {

    input {
        File table
        Int subsampling_depth
        String axis
        String sampled_table
    }

    qiime2_feature_table_subsample_ids_params task_params = object {
        table: table,
        subsampling_depth: subsampling_depth,
        axis: axis,
        sampled_table: sampled_table
    }

    command {
        q2dataflow wdl run feature_table subsample_ids ~{write_json(task_params)}
    }

    output {
        File sampled_table_file = "~{sampled_table}"
    }

}


workflow wkflw_qiime2_feature_table_subsample_ids {
input {
        File table
        Int subsampling_depth
        String axis
        String sampled_table
    }

    call qiime2_feature_table_subsample_ids {
        input: table=table, subsampling_depth=subsampling_depth, axis=axis, sampled_table=sampled_table
    }

}