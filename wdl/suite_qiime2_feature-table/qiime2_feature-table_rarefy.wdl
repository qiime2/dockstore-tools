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

struct qiime2_feature_table_rarefy_params {
    File table
    Int sampling_depth
    Boolean with_replacement
    String rarefied_table
}

task qiime2_feature_table_rarefy {

    input {
        File table
        Int sampling_depth
        Boolean with_replacement = false
        String rarefied_table
    }

    qiime2_feature_table_rarefy_params task_params = object {
        table: table,
        sampling_depth: sampling_depth,
        with_replacement: with_replacement,
        rarefied_table: rarefied_table
    }

    command {
        q2dataflow wdl run feature_table rarefy ~{write_json(task_params)}
    }

    output {
        File rarefied_table_file = "~{rarefied_table}"
    }

}


workflow wkflw_qiime2_feature_table_rarefy {
input {
        File table
        Int sampling_depth
        Boolean with_replacement = false
        String rarefied_table
    }

    call qiime2_feature_table_rarefy {
        input: table=table, sampling_depth=sampling_depth, with_replacement=with_replacement, rarefied_table=rarefied_table
    }

}
