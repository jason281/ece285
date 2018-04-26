include_directories(
  ${SOURCE_DIR}
  ${CUDA_TOOLKIT_INCLUDE}
  ${NVTX_INCLUDE_DIR}
  ${NVML_INCLUDE_DIR}
  ${FREEGLUT_INCLUDE_DIR}
  ${GLEW_INCLUDE_DIR}
  ${CUDA_TOOLKIT_SAMPLES_DIR}/common/inc
)

#######################################
#######################################
file(GLOB HEADERS *.h *.cuh)
source_group("Headers" FILES ${HEADERS})

cuda_add_executable( c2_nsight_profile_basic
${HEADERS}
sumMatrixGPU.cu
OPTIONS --cudart=shared  -lineinfo -arch sm_35 -use_fast_math -maxrregcount 104
DEBUG -Xptxas -v -g -G 
)

target_link_libraries( 
c2_nsight_profile_basic

${CUDA_CUDA_LIBRARY}
${CUDA_CUDART_LIBRARY}
${CUDA_CURAND_LIBRARY}
${NVML_DEBUG_LIBRARIES}
${NVTX_DEBUG_LIBRARIES}
${FREEGLUT_DEBUG_LIBRARIES}
${GLEW_DEBUG_LIBRARIES}
)

target_link_libraries( 
c2_nsight_profile_basic
${CUDA_CUDA_LIBRARY}
${CUDA_CUDART_LIBRARY}
${CUDA_CURAND_LIBRARY}
${FREEGLUT_RELEASE_LIBRARIES}
${GLEW_RELEASE_LIBRARIES}
)
#######################################
#######################################
file(GLOB HEADERS *.h *.cuh)
source_group("Headers" FILES ${HEADERS})

cuda_add_executable( c2_nsight_profile_basic_nvtx
${HEADERS}
sumMatrixGPU_nvToolsExt.cu
OPTIONS --cudart=shared  -lineinfo -arch sm_35 -use_fast_math  -maxrregcount 104
DEBUG -Xptxas -v -g -G 
)

target_link_libraries( 
c2_nsight_profile_basic_nvtx

${CUDA_CUDA_LIBRARY}
${CUDA_CUDART_LIBRARY}
${CUDA_CURAND_LIBRARY}
${NVML_DEBUG_LIBRARIES}
${NVTX_DEBUG_LIBRARIES}
${FREEGLUT_DEBUG_LIBRARIES}
${GLEW_DEBUG_LIBRARIES}
)

target_link_libraries( 
c2_nsight_profile_basic_nvtx
${CUDA_CUDA_LIBRARY}
${CUDA_CUDART_LIBRARY}
${CUDA_CURAND_LIBRARY}
${FREEGLUT_RELEASE_LIBRARIES}
${GLEW_RELEASE_LIBRARIES}
)

add_custom_command(TARGET c2_nsight_profile_basic_nvtx POST_BUILD     
COMMAND ${CMAKE_COMMAND} -E copy_if_different 
"${NVTX_INCLUDE_DIR}/../bin/x64/nvToolsExt64_1.dll"  
$<TARGET_FILE_DIR:c2_nsight_profile_basic_nvtx>)          

add_custom_command(TARGET c2_nsight_profile_basic_nvtx POST_BUILD     
COMMAND ${CMAKE_COMMAND} -E copy_if_different 
"${NVTX_INCLUDE_DIR}/../bin/x64/nvToolsExt64_1.dll"  
$<TARGET_FILE_DIR:c2_nsight_profile_basic_nvtx>) 