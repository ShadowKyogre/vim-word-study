if exists('g:word_study_loaded')
	finish
endif
let g:word_study_loaded = 1

com! -nargs=? ReverseDict  call WordStudy#ReverseDict(0, <f-args>)
com! -range -nargs=? ReverseDictV call WordStudy#ReverseDict(1, <f-args>)
com! -nargs=? SpelledLike  call WordStudy#SpelledLike(0, <f-args>)
com! -range -nargs=? SpelledLikeV call WordStudy#SpelledLike(1, <f-args>)
com! -nargs=? SoundsLike   call WordStudy#SoundsLike( 0, <f-args>)
com! -range -nargs=? SoundsLikeV  call WordStudy#SoundsLike( 1, <f-args>)
com! -nargs=? Etymology    call WordStudy#Etymology(  0, <f-args>)
com! -range -nargs=? EtymologyV   call WordStudy#Etymology(  1, <f-args>)
