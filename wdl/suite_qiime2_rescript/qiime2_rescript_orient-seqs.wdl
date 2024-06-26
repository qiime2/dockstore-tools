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

struct qiime2_rescript_orient_seqs_params {
    File sequences
    File? reference_sequences
    Int threads
    String? dbmask
    String? relabel
    Boolean? relabel_keep
    Boolean? relabel_md5
    Boolean? relabel_self
    Boolean? relabel_sha1
    Boolean? sizein
    Boolean? sizeout
    String oriented_seqs
    String unmatched_seqs
}

task qiime2_rescript_orient_seqs {

    input {
        File sequences
        File? reference_sequences
        Int threads = 1
        String? dbmask
        String? relabel
        Boolean? relabel_keep
        Boolean? relabel_md5
        Boolean? relabel_self
        Boolean? relabel_sha1
        Boolean? sizein
        Boolean? sizeout
        String oriented_seqs
        String unmatched_seqs
    }

    qiime2_rescript_orient_seqs_params task_params = object {
        sequences: sequences,
        reference_sequences: reference_sequences,
        threads: threads,
        dbmask: dbmask,
        relabel: relabel,
        relabel_keep: relabel_keep,
        relabel_md5: relabel_md5,
        relabel_self: relabel_self,
        relabel_sha1: relabel_sha1,
        sizein: sizein,
        sizeout: sizeout,
        oriented_seqs: oriented_seqs,
        unmatched_seqs: unmatched_seqs
    }

    command {
        q2dataflow wdl run rescript orient_seqs ~{write_json(task_params)}
    }

    output {
        File oriented_seqs_file = "~{oriented_seqs}"
        File unmatched_seqs_file = "~{unmatched_seqs}"
    }

}


workflow wkflw_qiime2_rescript_orient_seqs {
input {
        File sequences
        File? reference_sequences
        Int threads = 1
        String? dbmask
        String? relabel
        Boolean? relabel_keep
        Boolean? relabel_md5
        Boolean? relabel_self
        Boolean? relabel_sha1
        Boolean? sizein
        Boolean? sizeout
        String oriented_seqs
        String unmatched_seqs
    }

    call qiime2_rescript_orient_seqs {
        input: sequences=sequences, reference_sequences=reference_sequences, threads=threads, dbmask=dbmask, relabel=relabel, relabel_keep=relabel_keep, relabel_md5=relabel_md5, relabel_self=relabel_self, relabel_sha1=relabel_sha1, sizein=sizein, sizeout=sizeout, oriented_seqs=oriented_seqs, unmatched_seqs=unmatched_seqs
    }

}
