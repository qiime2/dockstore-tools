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

struct qiime2_diversity_pcoa_params {
    File distance_matrix
    Int? number_of_dimensions
    String pcoa
}

task qiime2_diversity_pcoa {

    input {
        File distance_matrix
        Int? number_of_dimensions
        String pcoa
    }

    qiime2_diversity_pcoa_params task_params = object {
        distance_matrix: distance_matrix,
        number_of_dimensions: number_of_dimensions,
        pcoa: pcoa
    }

    command {
        q2dataflow wdl run diversity pcoa ~{write_json(task_params)}
    }

    output {
        File pcoa_file = "~{pcoa}"
    }

}


workflow wkflw_qiime2_diversity_pcoa {
input {
        File distance_matrix
        Int? number_of_dimensions
        String pcoa
    }

    call qiime2_diversity_pcoa {
        input: distance_matrix=distance_matrix, number_of_dimensions=number_of_dimensions, pcoa=pcoa
    }

}
