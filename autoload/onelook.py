import vim
import json
from urllib import request
from urllib import parse as uparse

old_search_pattern = vim.eval('@/')
base_url="http://api.datamuse.com/words?{}"
onelooknr = int(vim.eval("bufwinnr('^onelook$')"))
word_to_look_up = vim.eval("expand('<cword>')")

if onelooknr > -1:
	vim.command('{}wincmd w'.format(onelooknr))
else:
	vim.command('silent keepalt belowright split onelook')

vim.command('setlocal noswapfile nobuflisted nospell nowrap modifiable')
vim.command('setlocal buftype=nofile bufhidden=hide')
vim.command('setlocal foldmethod=marker textwidth=80 wrapmargin=0 formatoptions=ant')

if len(sys.argv) == 2:
	args = uparse.urlencode({sys.argv[0]: sys.argv[1]})
elif len(sys.argv) == 3:
	args = uparse.urlencode({sys.argv[0]: sys.argv[1], 'max': sys.argv[2]})
else:
	exit(1)

data = request.urlopen(base_url.format(args))
lines=[ item['word'] for item in json.loads(data.read().decode('utf-8')) ]
lines.insert(0, "{} for {}".format(sys.argv[0], sys.argv[1]))

del vim.current.buffer[:]
vim.current.buffer[:]=lines

vim.command('g/./normal gqq')
vim.command('normal gg')
vim.command('setlocal nomodifiable filetype=onelook')
vim.command('nnoremap <silent> <buffer> q :q<CR>')
vim.command("call histdel('/', -1)")
vim.command('let @/ = {}'.format(repr(old_search_pattern)))

