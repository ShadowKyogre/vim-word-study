import vim
from urllib import parse as uparse
from lxml import html, etree
from cssselect import HTMLTranslator
import sys

htmltrans = HTMLTranslator()

old_search_pattern = vim.eval('@/')
base_url="http://etymonline.com/index.php?term={}"
etymologynr = int(vim.eval("bufwinnr('^etymology$')"))
word_to_look_up = sys.argv[0]
term_start = "{} {{{{{{"
term_end = "}}}"

if etymologynr > -1:
	vim.command('{}wincmd w'.format(etymologynr))
else:
	vim.command('silent keepalt belowright split etymology')

vim.command('setlocal noswapfile nobuflisted nospell nowrap modifiable')
vim.command('setlocal buftype=nofile bufhidden=hide')
vim.command('setlocal foldmethod=marker textwidth=80 wrapmargin=0')

term_xpath = etree.XPath(htmltrans.css_to_xpath('dt'))
linkfixes = etree.XPath(htmltrans.css_to_xpath("a.crossreference"))
foreignfixes = etree.XPath(htmltrans.css_to_xpath("span.foreign"))

definitions = html.parse(base_url.format(uparse.quote_plus(word_to_look_up)))
lines = []
for foreignfix in foreignfixes(definitions):
	foreignfix.text="<<{}>>".format(foreignfix.text)
for linkfix in linkfixes(definitions):
	linkfix.text=">>{}<<".format(linkfix.text)
for term_el in term_xpath(definitions):
	term_name = term_el[0].text
	lines.append(term_start.format(term_name))
	lines.extend(term_el.getnext().text_content().split('\r\n'))
	lines.append(term_end)

del vim.current.buffer[:]
vim.current.buffer[:]=lines

vim.command('g/[^{]$/normal gqq')
vim.command('normal gg')
vim.command('setlocal nomodifiable filetype=etymology')
vim.command('nnoremap <silent> <buffer> q :q<CR>')
vim.command("call histdel('/', -1)")
vim.command('let @/ = {}'.format(repr(old_search_pattern)))

def setupHighlighting():
	vim.command("syn clear")
	vim.command(r'syntax match termItem /^[^{]\+\( {{{\)\@=/')
	vim.command(r'syntax match foreignRef /<<[^ ;]\_[^><]*[^ ;]>>/')
	vim.command(r"syntax match otherTerm />>[^ ;]\_[^><]*[^ ;]<</")
	vim.command('hi def link termItem Keyword')
	vim.command('hi def link foreignRef Tag')
	vim.command('hi def link otherTerm Identifier')
	vim.command('let b:current_syntax="etymology"')

setupHighlighting()
