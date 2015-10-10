if !exists('s:word_study_did_init')
    let s:script_path = expand("<sfile>:p")
    let s:script_dir = expand("<sfile>:p:h")
	let s:word_study_did_init = 1
endif

function! WordStudy#GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! WordStudy#ReverseDict(useSel, ...)
	py3 import sys
	if a:0 > 0 
		py3 sys.argv = ['rd', vim.eval('a:1')]
	else
		if a:useSel && visualmode() != ""
			let visSel = GetVisualSelection()
		else
			let visSel = ""
		endif
		if a:useSel && visSel != ""
			py3 sys.argv = ['rd', vim.eval("visSel")]
		else
			py3 sys.argv = ['rd', vim.eval("expand('<cword>')")]
		endif
		if exists("g:word_study_max_sugs")
			py3 sys.argv.append(vim.eval("g:word_study_max_sugs"))
		endif
	endif
	exe "py3file ".s:script_dir."/onelook.py"
endfunc

function! WordStudy#SpelledLike(useSel, ...)
	py3 import sys
	if a:0 > 0 
		py3 sys.argv = ['sp', vim.eval('a:1')]
	else
		if a:useSel && visualmode() != ""
			let visSel = GetVisualSelection()
		else
			let visSel = ""
		endif
		if a:useSel && visSel != ""
			py3 sys.argv = ['sp', vim.eval("visSel")]
		else
			py3 sys.argv = ['sp', vim.eval("expand('<cword>')")]
		endif
		if exists("g:word_study_max_sugs")
			py3 sys.argv.append(vim.eval("g:word_study_max_sugs"))
		endif
	endif
	exe "py3file ".s:script_dir."/onelook.py"
endfunc

function! WordStudy#SoundsLike(useSel, ...)
	py3 import sys
	if a:0 > 0 
		py3 sys.argv = ['sl', vim.eval('a:1')]
	else
		if a:useSel && visualmode() != ""
			let visSel = GetVisualSelection()
		else
			let visSel = ""
		endif
	if a:useSel && visSel != ""
			py3 sys.argv = ['sl', vim.eval("visSel")]
		else
			py3 sys.argv = ['sl', vim.eval("expand('<cword>')")]
		endif
		if exists("g:word_study_max_sugs")
			py3 sys.argv.append(vim.eval("g:word_study_max_sugs"))
		endif
	endif
	exe "py3file ".s:script_dir."/onelook.py"
endfunc

function! WordStudy#Etymology(useSel, ...)
	py3 import sys
	if a:0 > 0 
		py3 sys.argv = [vim.eval('a:1')]
	else
		if a:useSel && visualmode() != ""
			let visSel = GetVisualSelection()
		else
			let visSel = ""
		endif
		if a:useSel && visSel != ""
			py3 sys.argv = [vim.eval("visSel")]
		else
			py3 sys.argv = [vim.eval("expand('<cword>')")]
		endif
		if exists("g:word_study_max_sugs")
			py3 sys.argv.append(vim.eval("g:word_study_max_sugs"))
		endif
	endif
	exe "py3file ".s:script_dir."/etyonline.py"
endfunc
