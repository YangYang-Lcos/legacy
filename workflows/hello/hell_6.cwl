#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: "Hello World"
doc: "Outputs a message using echo"

inputs:
  aaa_table: File
  bbb_table: File
 
outputs:
  response:
    outputSource:
      - join1/response
        
    type: File

steps:
  join1:
    label: "关联操作"
    run:
      class: CommandLineTool
      inputs:
        name:
          type: string
          doc: "The message to print"
          default: "Hello World"
          inputBinding:
            position: 1
        name2:
          type: string
      baseCommand: op
      arguments:
         - "-n"
         - "-e"
      stdout: response.txt
      outputs:
        response:
          type: stdout
    in:
      name:
        source: aaa_table
        valueFrom: ${self.basename}
      name2:
        source: bbb_table
        valueFrom: ${self.basename}
    out: [response]

    
    
