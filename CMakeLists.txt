cmake_minimum_required(VERSION 3.21)
project(rpc_bridge_multi_ipc C)

set(CMAKE_C_STANDARD 17)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
add_executable(bridge WIN32
    src/bridge.c
    src/game.c
    src/gui.c
    src/main.c
    src/service.c
    src/bridge.rc
)

target_compile_definitions(bridge PRIVATE
    _AMD64_
    GIT_COMMIT="multi-ipc"
    GIT_BRANCH="autodeafen"
    RPC_BRIDGE_NO_EMBEDDED_MANIFEST
)
target_compile_options(bridge PRIVATE
    -Wno-int-conversion
    -Wno-incompatible-pointer-types
)
target_link_options(bridge PRIVATE "LINKER:/manifest:no")
target_link_libraries(bridge PRIVATE
    advapi32
    gdi32
    kernel32
    shell32
    user32
    ws2_32
)
