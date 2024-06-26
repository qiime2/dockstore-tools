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

struct qiime2_feature_table_presence_absence_params {
    File table
    String presence_absence_table
}

task qiime2_feature_table_presence_absence {

    input {
        File table
        String presence_absence_table
    }

    qiime2_feature_table_presence_absence_params task_params = object {
        table: table,
        presence_absence_table: presence_absence_table
    }

    command {
        q2dataflow wdl run feature_table presence_absence ~{write_json(task_params)}
    }

    output {
        File presence_absence_table_file = "~{presence_absence_table}"
    }

}


workflow wkflw_qiime2_feature_table_presence_absence {
input {
        File table
        String presence_absence_table
    }

    call qiime2_feature_table_presence_absence {
        input: table=table, presence_absence_table=presence_absence_table
    }

}
