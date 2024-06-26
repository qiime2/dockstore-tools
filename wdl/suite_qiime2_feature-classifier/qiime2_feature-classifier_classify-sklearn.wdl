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

struct qiime2_feature_classifier_classify_sklearn_params {
    File reads
    File classifier
    String reads_per_batch
    Int n_jobs
    String pre_dispatch
    String confidence
    String read_orientation
    String classification
}

task qiime2_feature_classifier_classify_sklearn {

    input {
        File reads
        File classifier
        String reads_per_batch = 'auto'
        Int n_jobs = 1
        String pre_dispatch = "2*n_jobs"
        String confidence = '0.7'
        String read_orientation = "auto"
        String classification
    }

    qiime2_feature_classifier_classify_sklearn_params task_params = object {
        reads: reads,
        classifier: classifier,
        reads_per_batch: reads_per_batch,
        n_jobs: n_jobs,
        pre_dispatch: pre_dispatch,
        confidence: confidence,
        read_orientation: read_orientation,
        classification: classification
    }

    command {
        q2dataflow wdl run feature_classifier classify_sklearn ~{write_json(task_params)}
    }

    output {
        File classification_file = "~{classification}"
    }

}


workflow wkflw_qiime2_feature_classifier_classify_sklearn {
input {
        File reads
        File classifier
        String reads_per_batch = 'auto'
        Int n_jobs = 1
        String pre_dispatch = "2*n_jobs"
        String confidence = '0.7'
        String read_orientation = "auto"
        String classification
    }

    call qiime2_feature_classifier_classify_sklearn {
        input: reads=reads, classifier=classifier, reads_per_batch=reads_per_batch, n_jobs=n_jobs, pre_dispatch=pre_dispatch, confidence=confidence, read_orientation=read_orientation, classification=classification
    }

}
