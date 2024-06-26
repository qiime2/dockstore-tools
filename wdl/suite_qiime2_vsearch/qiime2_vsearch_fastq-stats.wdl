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

struct qiime2_vsearch_fastq_stats_params {
    File sequences
    Int threads
    String visualization
}

task qiime2_vsearch_fastq_stats {

    input {
        File sequences
        Int threads = 1
        String visualization
    }

    qiime2_vsearch_fastq_stats_params task_params = object {
        sequences: sequences,
        threads: threads,
        visualization: visualization
    }

    command {
        q2dataflow wdl run vsearch fastq_stats ~{write_json(task_params)}
    }

    output {
        File visualization_file = "~{visualization}"
    }

}


workflow wkflw_qiime2_vsearch_fastq_stats {
input {
        File sequences
        Int threads = 1
        String visualization
    }

    call qiime2_vsearch_fastq_stats {
        input: sequences=sequences, threads=threads, visualization=visualization
    }

}
