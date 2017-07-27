cmake_minimum_required(VERSION 2.6 FATAL_ERROR)
set(name Quartic)
project(${name})


set(SOURCES
   quartic_real.c
)


add_library( ${name}  SHARED ${SOURCES} )
add_executable( ${name}Test quartic_real_main.c  )
target_link_libraries( ${name}Test ${name} )


install(TARGETS ${name}      DESTINATION lib)
install(TARGETS ${name}Test  DESTINATION lib)










