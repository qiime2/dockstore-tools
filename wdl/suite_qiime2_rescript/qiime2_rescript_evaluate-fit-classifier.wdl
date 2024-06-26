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

struct qiime2_rescript_evaluate_fit_classifier_params {
    File sequences
    File taxonomy
    String reads_per_batch
    Int n_jobs
    String confidence
    String classifier
    String evaluation
    String observed_taxonomy
}

task qiime2_rescript_evaluate_fit_classifier {

    input {
        File sequences
        File taxonomy
        String reads_per_batch = 'auto'
        Int n_jobs = 1
        String confidence = '0.7'
        String classifier
        String evaluation
        String observed_taxonomy
    }

    qiime2_rescript_evaluate_fit_classifier_params task_params = object {
        sequences: sequences,
        taxonomy: taxonomy,
        reads_per_batch: reads_per_batch,
        n_jobs: n_jobs,
        confidence: confidence,
        classifier: classifier,
        evaluation: evaluation,
        observed_taxonomy: observed_taxonomy
    }

    command {
        q2dataflow wdl run rescript evaluate_fit_classifier ~{write_json(task_params)}
    }

    output {
        File classifier_file = "~{classifier}"
        File evaluation_file = "~{evaluation}"
        File observed_taxonomy_file = "~{observed_taxonomy}"
    }

}


workflow wkflw_qiime2_rescript_evaluate_fit_classifier {
input {
        File sequences
        File taxonomy
        String reads_per_batch = 'auto'
        Int n_jobs = 1
        String confidence = '0.7'
        String classifier
        String evaluation
        String observed_taxonomy
    }

    call qiime2_rescript_evaluate_fit_classifier {
        input: sequences=sequences, taxonomy=taxonomy, reads_per_batch=reads_per_batch, n_jobs=n_jobs, confidence=confidence, classifier=classifier, evaluation=evaluation, observed_taxonomy=observed_taxonomy
    }

}
