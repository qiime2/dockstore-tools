#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_edit_taxonomy
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Edit taxonomy strings with find and replace terms.
doc: A method that allows the user to edit taxonomy strings. This is often used to
  fix inconsistent and/or inccorect taxonomic annotations. The user can either provide
  two separate lists of strings, i.e. 'search-strings', and 'replacement-strings',
  on the command line, and/or a single tab-delimited replacement map file containing
  a list of these strings. In both cases the number of search strings must match the
  number of replacement strings. That is the first string in 'search-strings' is replaced
  with the first string in 'replacement-strings', and so on. In the case that both
  search / replacement strings, and a replacement map file are provided, they will
  be merged.
inputs:
  taxonomy:
    doc: Taxonomy strings data to be edited.
    type: File
  q2cwl_metafile_replacement_map:
    doc: A tab-delimitad metadata file in which the strings in the 'id' column are
      replaced by the 'replacement-strings' in the second column. All strings in the
      'id' column must be unique!
    type: File?
  replacement_map:
    doc: Column name to use from 'replacement_map' file
    type: string?
  search_strings:
    doc: Only used in conjuntion with 'replacement-strings'. Each string in this list
      is searched for and replaced with a string in the list of 'replace-ment-strings'.
      That is the first string in 'search-strings' is  replaced with the first string
      in 'replacement-strings', and so on. The number of 'search-strings' must be
      equal to the number of replacement strings.
    type: string[]?
  replacement_strings:
    doc: Only used in conjuntion with 'search-strings'. This must contain the same
      number of replacement strings as search strings. See 'search-strings' parameter
      text for more details.
    type: string[]?
  use_regex:
    default: false
    doc: Toggle regular expressions. By default, only litereal substring matching
      is performed.
    type: boolean
  edited_taxonomy:
    doc: Taxonomy in which the original strings are replaced by user-supplied strings.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- edit_taxonomy
- inputs.json
outputs:
  edited_taxonomy_file:
    doc: Taxonomy in which the original strings are replaced by user-supplied strings.
    outputBinding:
      glob: $(inputs.edited_taxonomy)
    type: File
