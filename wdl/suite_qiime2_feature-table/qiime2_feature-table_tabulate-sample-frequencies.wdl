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

struct qiime2_feature_table_tabulate_sample_frequencies_params {
    File table
    String sample_frequencies
}

task qiime2_feature_table_tabulate_sample_frequencies {

    input {
        File table
        String sample_frequencies
    }

    qiime2_feature_table_tabulate_sample_frequencies_params task_params = object {
        table: table,
        sample_frequencies: sample_frequencies
    }

    command {
        q2dataflow wdl run feature_table tabulate_sample_frequencies ~{write_json(task_params)}
    }

    output {
        File sample_frequencies_file = "~{sample_frequencies}"
    }

}


workflow wkflw_qiime2_feature_table_tabulate_sample_frequencies {
input {
        File table
        String sample_frequencies
    }

    call qiime2_feature_table_tabulate_sample_frequencies {
        input: table=table, sample_frequencies=sample_frequencies
    }

}
