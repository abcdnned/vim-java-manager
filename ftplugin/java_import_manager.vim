if exists("g:java_import_manager")
    finish
endif

let g:java_import_manager = 1

if !exists("g:jim_root")
    let g:jim_root = 'java'
endif

fun! s:isimpol(line)
    return stridx(a:line, 'import') == 0
endfunction

fun! s:jim_declare_package()
    let op = line('.')
    let oc = col('.')

    let dir = expand('%:p:h')
    let s = stridx(dir, g:jim_root)
    if s > 0
        let dir = strpart(dir, s + strlen(g:jim_root) + 1)
    endif
    let dir = substitute(dir, '[\\\/]', '.', 'g')

    normal gg
    exe "normal ^Cpackage " . dir . ';'

    call cursor(op,oc)
endfun

fun! s:jim_prepare()
    normal mj
    let a:i = 2
    let a:n = line('$')
    while a:i < a:n
        let a:nnbl = nextnonblank(a:i)
        if a:nnbl == -1
           break 
        endif
        let a:nl = getline(a:nnbl)
        if !s:isimpol(a:nl)
            break
        endif
    let a:i += 1
    endwhile

    call append(a:i, '')
    call cursor(a:i,0)
    startinsert
endfunction

let s:importPattern = '^\s*import\s\+.*;\?$'

fun! s:jim_sort()
    let op = line('.')
    let oc = col('.')
    
    call cursor(1,0)

    let s = search(s:importPattern)
    if s > 0
        let firstLine = s
        normal! G
        exe "" . firstLine . "," . search(s:importPattern, 'b') . "sort u"
        if getline(".") =~ "^\s*$"
            delete
        endif
    endif

    call cursor(op,oc)
endfunction


command! JIMPrepareImport :call s:jim_prepare()
command! JIMSortImport :call s:jim_sort()
command! JIMDeclarePackage :call s:jim_declare_package()

map <script> <unique> <silent> <Leader>1i :call <SID>jim_prepare()<CR>
map <script> <unique> <silent> <Leader>1s :call <SID>jim_sort()<CR>
map <script> <unique> <silent> <Leader>1p :call <SID>jim_declare_package()<CR>
