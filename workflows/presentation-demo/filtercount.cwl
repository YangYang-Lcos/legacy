#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0
label: "近7天高危地区来宁人员"
doc: "近7天高危地区来宁人员"
requirements:
  ScatterFeatureRequirement: {}
  DockerRequirement: 
    dockerPull: debian:8
steps:
  search_texts:
    run: grep.cwl
    inputs:
      pattern: pattern
      file_to_search: texts
    scatter: file_to_search
    outputs: [ results ]

  count_matches:
    run: wc.cwl
    inputs:
      files: search_texts/results
    outputs: [ counts ]

