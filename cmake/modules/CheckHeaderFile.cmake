include(CheckIncludeFile)

function( check_header_file header_name header_definition)
    check_include_file("${header_name}" ${header_definition})
    if (${header_definition})
        add_definitions(-D${header_definition})
    endif()
endfunction()