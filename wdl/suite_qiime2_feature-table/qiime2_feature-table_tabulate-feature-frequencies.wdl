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

struct qiime2_feature_table_tabulate_feature_frequencies_params {
    File table
    String feature_frequencies
}

task qiime2_feature_table_tabulate_feature_frequencies {

    input {
        File table
        String feature_frequencies
    }

    qiime2_feature_table_tabulate_feature_frequencies_params task_params = object {
        table: table,
        feature_frequencies: feature_frequencies
    }

    command {
        q2dataflow wdl run feature_table tabulate_feature_frequencies ~{write_json(task_params)}
    }

    output {
        File feature_frequencies_file = "~{feature_frequencies}"
    }

}


workflow wkflw_qiime2_feature_table_tabulate_feature_frequencies {
input {
        File table
        String feature_frequencies
    }

    call qiime2_feature_table_tabulate_feature_frequencies {
        input: table=table, feature_frequencies=feature_frequencies
    }

}
