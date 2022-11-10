#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

label: "近7天高危地区来宁人员"
doc: "近7天高危地区来宁人员"

inputs:
  tarball: File
  name_of_file_to_extract: string

outputs:
  response:
    outputSource: step0/response
    type: File

steps:
  step0:
    run:
      class: CommandLineTool
      inputs:
        message:
          type: string
          doc: "The message to print"
          default: "Hello World"
          inputBinding:
            position: 1
      baseCommand: echo
      stdout: response.txt
      outputs:
        response:
          type: stdout
    in: []
    out: [response]
