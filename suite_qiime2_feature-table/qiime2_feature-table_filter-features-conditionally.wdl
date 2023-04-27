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

struct qiime2_feature_table_filter_features_conditionally_params {
    File table
    Float abundance
    Float prevalence
    String filtered_table
}

task qiime2_feature_table_filter_features_conditionally {

    input {
        File table
        Float abundance
        Float prevalence
        String filtered_table
    }

    qiime2_feature_table_filter_features_conditionally_params task_params = object {
        table: table,
        abundance: abundance,
        prevalence: prevalence,
        filtered_table: filtered_table
    }

    command {
        q2dataflow q2wdl run feature_table filter_features_conditionally ~{write_json(task_params)}
    }

    output {
        File filtered_table_file = "~{filtered_table}"
    }

}


workflow wkflw_qiime2_feature_table_filter_features_conditionally {
input {
        File table
        Float abundance
        Float prevalence
        String filtered_table
    }

    call qiime2_feature_table_filter_features_conditionally {
        input: table=table, abundance=abundance, prevalence=prevalence, filtered_table=filtered_table
    }

}
