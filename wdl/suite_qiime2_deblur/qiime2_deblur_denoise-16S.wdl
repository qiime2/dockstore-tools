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

struct qiime2_deblur_denoise_16S_params {
    File demultiplexed_seqs
    Int trim_length
    Int left_trim_len
    Boolean sample_stats
    Float mean_error
    Float indel_prob
    Int indel_max
    Int min_reads
    Int min_size
    Int jobs_to_start
    Boolean hashed_feature_ids
    String table
    String representative_sequences
    String stats
}

task qiime2_deblur_denoise_16S {

    input {
        File demultiplexed_seqs
        Int trim_length
        Int left_trim_len = 0
        Boolean sample_stats = false
        Float mean_error = 0.005
        Float indel_prob = 0.01
        Int indel_max = 3
        Int min_reads = 10
        Int min_size = 2
        Int jobs_to_start = 1
        Boolean hashed_feature_ids = true
        String table
        String representative_sequences
        String stats
    }

    qiime2_deblur_denoise_16S_params task_params = object {
        demultiplexed_seqs: demultiplexed_seqs,
        trim_length: trim_length,
        left_trim_len: left_trim_len,
        sample_stats: sample_stats,
        mean_error: mean_error,
        indel_prob: indel_prob,
        indel_max: indel_max,
        min_reads: min_reads,
        min_size: min_size,
        jobs_to_start: jobs_to_start,
        hashed_feature_ids: hashed_feature_ids,
        table: table,
        representative_sequences: representative_sequences,
        stats: stats
    }

    command {
        q2dataflow wdl run deblur denoise_16S ~{write_json(task_params)}
    }

    output {
        File table_file = "~{table}"
        File representative_sequences_file = "~{representative_sequences}"
        File stats_file = "~{stats}"
    }

}


workflow wkflw_qiime2_deblur_denoise_16S {
input {
        File demultiplexed_seqs
        Int trim_length
        Int left_trim_len = 0
        Boolean sample_stats = false
        Float mean_error = 0.005
        Float indel_prob = 0.01
        Int indel_max = 3
        Int min_reads = 10
        Int min_size = 2
        Int jobs_to_start = 1
        Boolean hashed_feature_ids = true
        String table
        String representative_sequences
        String stats
    }

    call qiime2_deblur_denoise_16S {
        input: demultiplexed_seqs=demultiplexed_seqs, trim_length=trim_length, left_trim_len=left_trim_len, sample_stats=sample_stats, mean_error=mean_error, indel_prob=indel_prob, indel_max=indel_max, min_reads=min_reads, min_size=min_size, jobs_to_start=jobs_to_start, hashed_feature_ids=hashed_feature_ids, table=table, representative_sequences=representative_sequences, stats=stats
    }

}
