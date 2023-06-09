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

struct qiime2_vsearch_merge_pairs_params {
    File demultiplexed_seqs
    Int? truncqual
    Int minlen
    Int? maxns
    Boolean allowmergestagger
    Int minovlen
    Int maxdiffs
    Int? minmergelen
    Int? maxmergelen
    Float? maxee
    Int threads
    String merged_sequences
}

task qiime2_vsearch_merge_pairs {

    input {
        File demultiplexed_seqs
        Int? truncqual
        Int minlen = 1
        Int? maxns
        Boolean allowmergestagger = false
        Int minovlen = 10
        Int maxdiffs = 10
        Int? minmergelen
        Int? maxmergelen
        Float? maxee
        Int threads = 1
        String merged_sequences
    }

    qiime2_vsearch_merge_pairs_params task_params = object {
        demultiplexed_seqs: demultiplexed_seqs,
        truncqual: truncqual,
        minlen: minlen,
        maxns: maxns,
        allowmergestagger: allowmergestagger,
        minovlen: minovlen,
        maxdiffs: maxdiffs,
        minmergelen: minmergelen,
        maxmergelen: maxmergelen,
        maxee: maxee,
        threads: threads,
        merged_sequences: merged_sequences
    }

    command {
        q2dataflow q2wdl run vsearch merge_pairs ~{write_json(task_params)}
    }

    output {
        File merged_sequences_file = "~{merged_sequences}"
    }

}


workflow wkflw_qiime2_vsearch_merge_pairs {
input {
        File demultiplexed_seqs
        Int? truncqual
        Int minlen = 1
        Int? maxns
        Boolean allowmergestagger = false
        Int minovlen = 10
        Int maxdiffs = 10
        Int? minmergelen
        Int? maxmergelen
        Float? maxee
        Int threads = 1
        String merged_sequences
    }

    call qiime2_vsearch_merge_pairs {
        input: demultiplexed_seqs=demultiplexed_seqs, truncqual=truncqual, minlen=minlen, maxns=maxns, allowmergestagger=allowmergestagger, minovlen=minovlen, maxdiffs=maxdiffs, minmergelen=minmergelen, maxmergelen=maxmergelen, maxee=maxee, threads=threads, merged_sequences=merged_sequences
    }

}
