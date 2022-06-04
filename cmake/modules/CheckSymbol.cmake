include (CheckSymbolExists)

function(check_symbol function_name header_file function_def)
    check_symbol_exists(${function_name} ${header_file} ${function_def})
    if (${function_def})
        add_definitions(-D${function_def})
    endif()
endfunction()