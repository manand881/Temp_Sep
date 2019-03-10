cmake_minimum_required(VERSION 3.13)
project(Temp_Sep Fortran)


enable_language(Fortran)
add_executable(Temp_Sep main.f90)
add_custom_target(temperature.dat)