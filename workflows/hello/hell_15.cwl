#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: "Hello World"
doc: "Outputs a message using echo"

inputs:
  train_tickets_real_time: File
  civil_aviation_book_real_time: File
  rule_table: File
  train_tickets_off_time: File
  civil_aviation_book_off_time: File
outputs:
  unitag_dws:
    outputSource: merge/unitag_dws
    type: Any
  response:
    outputSource:
      - join1/response
      - join2/response 
      - join3/response 
    type: Any
  unitag_result:
    outputSource: storage/unitag_result
    type: Any
steps:
  join1:
    label: "关联操作"
    run:
      class: CommandLineTool
      inputs:
        areacode1:
          type: string
          inputBinding:
            position: 1
        areacode2:
          type: string
      baseCommand: join
      arguments:
      outputs:
        response:
          type: Any
    in:
      areacode1:
        source: train_tickets_real_time
        valueFrom: ${self.basename}
      areacode2:
        source: rule_table
        valueFrom: ${self.basename}
    out: [response]
  join2:
    run:
      class: CommandLineTool
      inputs:
        areacode1:
          type: string
          inputBinding:
            position: 1
        areacode2:
          type: string
      baseCommand: instersect
      outputs:
        response:
          type: Any
    in:
      areacode1:
        source: civil_aviation_book_real_time
        valueFrom: ${self.basename}
      areacode2:
        source: rule_table
        valueFrom: ${self.basename}
    out: [response]
  union1:
    run:
      class: CommandLineTool
      inputs:
        train_tickets_off_time:
          type: File
          inputBinding:
            position: 1
        civil_aviation_book_off_time:
          type: File
      baseCommand: join
      outputs:
        union_res:
          type: Any
    in:
      train_tickets_off_time: train_tickets_off_time
      civil_aviation_book_off_time: civil_aviation_book_off_time
    out: [union_res] 
  join3:
    run:
      class: CommandLineTool
      inputs:
        areacode1:
          type: string
          inputBinding:
            position: 1
        areacode2:
          type: string
      baseCommand: join
      outputs:
        response:
          type: Any
    in:
      areacode1: 
        source: union1/union_res
        valueFrom: ${self.basename}
      areacode2:
        source: rule_table
        valueFrom: ${self.basename}
    out: [response]        
  merge:
   run:
      class: CommandLineTool
      inputs:
        response:
          type: Any
          inputBinding:
            position: 1
        unitag_dws:
          type: Any
      baseCommand: join
      outputs:
        unitag_dws:
          type: Any
   in:
      response: 
        source:
          - join1/response
          - join2/response 
          - join3/response 
   out: [unitag_dws]  
  storage:
    run:
      class: CommandLineTool
      inputs:      
        unitag_dws:
          type: Any
      baseCommand: join    
      outputs:
        unitag_result:
          type: Any
    in:
      unitag_dws: 
        source:
          - merge/unitag_dws       
    out: [unitag_result]
