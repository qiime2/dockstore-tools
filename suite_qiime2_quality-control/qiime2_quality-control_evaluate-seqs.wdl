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

struct qiime2_quality_control_evaluate_seqs_params {
    File query_sequences
    File reference_sequences
    Boolean show_alignments
    String visualization
}

task qiime2_quality_control_evaluate_seqs {

    input {
        File query_sequences
        File reference_sequences
        Boolean show_alignments = false
        String visualization
    }

    qiime2_quality_control_evaluate_seqs_params task_params = object {
        query_sequences: query_sequences,
        reference_sequences: reference_sequences,
        show_alignments: show_alignments,
        visualization: visualization
    }

    command {
        q2dataflow q2wdl run quality_control evaluate_seqs ~{write_json(task_params)}
    }

    output {
        File visualization_file = "~{visualization}"
    }

}


workflow wkflw_qiime2_quality_control_evaluate_seqs {
input {
        File query_sequences
        File reference_sequences
        Boolean show_alignments = false
        String visualization
    }

    call qiime2_quality_control_evaluate_seqs {
        input: query_sequences=query_sequences, reference_sequences=reference_sequences, show_alignments=show_alignments, visualization=visualization
    }

}
