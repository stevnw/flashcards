# Alt files for flashcards

All of these are different datasets from http://frequencylists.blogspot.com/ - I have not personally checked them. 

To put them into the correct format, use the totsv.py script. I.e. If you want to get the Russian ones;

<pre> python totsv.py russian</pre>

This will then geneate {language}_sentences.tsv

Simply rename this to sentences.tsv and it will work on with application.

I have also added two things;

Engine and voice variables - both of which are in the config.txt

i.e. if you want to use Russian voices;

Get either the Anna or Irina voices and keep the engine as rhvoice

Alternatively for languages that do not have voices on rhvoice, try pico2wave - or espeak (this one honestly sounds rubbish).


-----

#### Pico2wave config example - i.e. Spanish

<pre>
  voice=es-ES
  engine=pico
</pre>


#### eSpeak config example - i.e. Spanish

<pre>
  voice=es
  engine=espeak
</pre>
