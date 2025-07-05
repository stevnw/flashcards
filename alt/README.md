# Alt files for flashcards

All of these are different datasets from http://frequencylists.blogspot.com/ - I have not personally checked them. 

To put them into the correct format, use the totsv.py script. I.e. If you want to get the Russian ones;

<pre> python totsv.py russian</pre>

This will then geneate {language}_sentences.tsv

Simply rename this to sentences and it will work on with flashcards.nim.

I have now added two things;

Engine and voice variables - both of which are in the config.txt

i.e. if you want to use Russian voices;

Get either the Anna or Irina voices and keep the engine as rhvoice

Alternatively for languages that do not have voices on rhvoice, try espeak or possibly another one. You may need to mod the program further to allow for this. Personally I find espeak is quite horrid.
