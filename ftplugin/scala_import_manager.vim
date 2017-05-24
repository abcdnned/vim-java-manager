if exists("b:jim_scala_root")
    finish
endif

let b:jim_scala_root = 'scala'

fun! s:isimpol(line)
    return stridx(a:line, 'import') == 0
endfunction

fun! s:jim_scala_declare_package()
    let op = line('.')
    let oc = col('.')

    let dir = expand('%:p:h')
    let s = stridx(dir, b:jim_scala_root)
    if s > 0
        let dir = strpart(dir, s + strlen(b:jim_scala_root) + 1)
    endif
    let dir = substitute(dir, '[\\\/]', '.', 'g')

    normal gg
    exe "normal ^Cpackage " . dir

    call cursor(op,oc)
endfun

fun! s:jim_scala_prepare()
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

fun! s:jim_scala_sort()
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


map <buffer> <script> <unique> <silent> <Leader>1i :call <SID>jim_scala_prepare()<CR>
map <buffer> <script> <unique> <silent> <Leader>1s :call <SID>jim_scala_sort()<CR>
map <buffer> <script> <unique> <silent> <Leader>1p :call <SID>jim_scala_declare_package()<CR>
