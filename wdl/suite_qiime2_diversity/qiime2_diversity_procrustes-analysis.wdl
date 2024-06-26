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

struct qiime2_diversity_procrustes_analysis_params {
    File reference
    File other
    Int dimensions
    String permutations
    String transformed_reference
    String transformed_other
    String disparity_results
}

task qiime2_diversity_procrustes_analysis {

    input {
        File reference
        File other
        Int dimensions = 5
        String permutations = '999'
        String transformed_reference
        String transformed_other
        String disparity_results
    }

    qiime2_diversity_procrustes_analysis_params task_params = object {
        reference: reference,
        other: other,
        dimensions: dimensions,
        permutations: permutations,
        transformed_reference: transformed_reference,
        transformed_other: transformed_other,
        disparity_results: disparity_results
    }

    command {
        q2dataflow wdl run diversity procrustes_analysis ~{write_json(task_params)}
    }

    output {
        File transformed_reference_file = "~{transformed_reference}"
        File transformed_other_file = "~{transformed_other}"
        File disparity_results_file = "~{disparity_results}"
    }

}


workflow wkflw_qiime2_diversity_procrustes_analysis {
input {
        File reference
        File other
        Int dimensions = 5
        String permutations = '999'
        String transformed_reference
        String transformed_other
        String disparity_results
    }

    call qiime2_diversity_procrustes_analysis {
        input: reference=reference, other=other, dimensions=dimensions, permutations=permutations, transformed_reference=transformed_reference, transformed_other=transformed_other, disparity_results=disparity_results
    }

}
