#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  tarball: 'qqqqq'
  name_of_file_to_extract: '1111111'

outputs:
  compiled_class:
    type: File
    outputSource: compile/classfile

steps:
  untar:
    run: 
    in:
      tarfile: tarball
      extractfile: name_of_file_to_extract
    out: [extracted_file]

  compile:
    run:
    in:
      src: untar/extracted_file
    out: [classfile]
