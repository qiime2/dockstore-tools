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

struct qiime2_tools_export_params {
    File input_location
    String? output_format
    String output_location
}

task qiime2_tools_export {

    input {
        File input_location
        String? output_format
        String output_location
    }

    qiime2_tools_export_params task_params = object {
        input_location: input_location,
        output_format: output_format,
        output_location: output_location
    }

    command {
        q2dataflow q2wdl run tools export ~{write_json(task_params)}
    }

    

}


workflow wkflw_qiime2_tools_export {
input {
        File input_location
        String? output_format
        String output_location
    }

    call qiime2_tools_export {
        input: input_location=input_location, output_format=output_format, output_location=output_location
    }

}
