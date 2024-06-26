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

struct qiime2_rescript_evaluate_cross_validate_params {
    File sequences
    File taxonomy
    Int k
    Int random_state
    String reads_per_batch
    Int n_jobs
    String confidence
    String expected_taxonomy
    String observed_taxonomy
    String evaluation
}

task qiime2_rescript_evaluate_cross_validate {

    input {
        File sequences
        File taxonomy
        Int k = 3
        Int random_state = 0
        String reads_per_batch = 'auto'
        Int n_jobs = 1
        String confidence = '0.7'
        String expected_taxonomy
        String observed_taxonomy
        String evaluation
    }

    qiime2_rescript_evaluate_cross_validate_params task_params = object {
        sequences: sequences,
        taxonomy: taxonomy,
        k: k,
        random_state: random_state,
        reads_per_batch: reads_per_batch,
        n_jobs: n_jobs,
        confidence: confidence,
        expected_taxonomy: expected_taxonomy,
        observed_taxonomy: observed_taxonomy,
        evaluation: evaluation
    }

    command {
        q2dataflow wdl run rescript evaluate_cross_validate ~{write_json(task_params)}
    }

    output {
        File expected_taxonomy_file = "~{expected_taxonomy}"
        File observed_taxonomy_file = "~{observed_taxonomy}"
        File evaluation_file = "~{evaluation}"
    }

}


workflow wkflw_qiime2_rescript_evaluate_cross_validate {
input {
        File sequences
        File taxonomy
        Int k = 3
        Int random_state = 0
        String reads_per_batch = 'auto'
        Int n_jobs = 1
        String confidence = '0.7'
        String expected_taxonomy
        String observed_taxonomy
        String evaluation
    }

    call qiime2_rescript_evaluate_cross_validate {
        input: sequences=sequences, taxonomy=taxonomy, k=k, random_state=random_state, reads_per_batch=reads_per_batch, n_jobs=n_jobs, confidence=confidence, expected_taxonomy=expected_taxonomy, observed_taxonomy=observed_taxonomy, evaluation=evaluation
    }

}
