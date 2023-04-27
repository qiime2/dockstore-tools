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

struct qiime2_feature_table_merge_params {
    Array[File] tables
    String overlap_method
    String merged_table
}

task qiime2_feature_table_merge {

    input {
        Array[File] tables
        String overlap_method = 'error_on_overlapping_sample'
        String merged_table
    }

    qiime2_feature_table_merge_params task_params = object {
        tables: tables,
        overlap_method: overlap_method,
        merged_table: merged_table
    }

    command {
        q2dataflow q2wdl run feature_table merge ~{write_json(task_params)}
    }

    output {
        File merged_table_file = "~{merged_table}"
    }

}


workflow wkflw_qiime2_feature_table_merge {
input {
        Array[File] tables
        String overlap_method = 'error_on_overlapping_sample'
        String merged_table
    }

    call qiime2_feature_table_merge {
        input: tables=tables, overlap_method=overlap_method, merged_table=merged_table
    }

}
