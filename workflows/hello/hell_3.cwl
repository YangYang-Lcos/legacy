#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: "Hello World"
doc: "Outputs a message using echo"

inputs:
  aaa_table: File
  bbb_table: File
  ccc_table: File

outputs:
  response:
    outputSource: response
    type: File

steps:
  join1:
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
      arguments:
         - "-n"
         - "-e"
      stdout: response.txt
      outputs:
        response:
          type: stdout
    in:
      aaa_table: aaa_table
      bbb_table: bbb_table
    out: [response]
  join2:
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
      arguments:
         - "-n"
         - "-e"
      stdout: response.txt
      outputs:
        response:
          type: stdout
    in:
      aaa_table: aaa_table
      ccc_table: ccc_table
    out: [response]
    
    
