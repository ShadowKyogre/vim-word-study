Vim Word Study
==============
**Requires Python 3 compiled for your (Neo)vim install.**

I should probably backport this later.

Quickly look up etymologies, words that match concepts, similarly spelled
words, and similar sounding words all from the comfort of vim. The following
commands are defined.

* **ReverseDict [{words}]** - Look up words that match the concept described
  by the argument or by the closest concept under the cursor.
* **ReverseDictV [{words}]** - Similar to the above, but it uses your 
visual selection.
* **SpelledLike [{words}]** - Look up words that are spelled like
  the argument or by the closest word under the cursor.
* **SpelledLikeV [{words}]** - Similar to the above, but it uses your 
visual selection.
* **SoundsLike [{words}]** - Look up words that are pronounced like
  the argument or by the closest word under the cursor.
* **SoundsLikeV [{words}]** - Similar to the above, but it uses your 
visual selection.
* **Etymology [{words}]** - Look up the origin(s) of the word by the
  argument or by the closest word under the cursor.
* **EtymologyV [{words}]** - Similar to the above, but it uses your 
visual selection.
