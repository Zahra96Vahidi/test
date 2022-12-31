
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name adc128s102 -dir "D:/fpga/adc128s102/planAhead_run_1" -part xc6slx9tqg144-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/fpga/adc128s102/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/fpga/adc128s102} {ipcore_dir} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
link_design
