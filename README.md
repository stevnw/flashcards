# Flashcards
A simple flashcard program written in Nim using nigui - using rhvoice for audio

![image](https://github.com/user-attachments/assets/d1740b91-444c-4731-9d20-8cf3712bb4db)


### Requirements/Compile
Reqs:

<pre> nimble install nigui </pre>

https://rhvoice.org/

Compile:

<pre> nim c -r flashcards.nim </pre>


### Data set organisation

See the Alt folder first, there are a few language options also from the same place I got the Polish dataset. There is also a python script to turn other datasets from the same site into the correct form needed.

Use a .tsv named "sentences.tsv"

Needs to looks something like:

<pre>
  Polish sentence	English meaning	Frequency
  Co to jest?	What's this?	[ 22 6 1 ]
  Co jest?	What's up?	[ 22 1 ]
  To co?	Then what?	[ 6 22 ]
  Nie mogę.	I can not.	[ 5 24 ]
  Nie, nie ma za dużo.	No, not too much.	[ 5 5 12 11 42 ]
  Nie, to nie tak.	That's not how I feel.	[ 5 6 5 54 ]  
</pre>

Frequency doesn't really matter - it was just apart of the dataset I used from: http://frequencylists.blogspot.com/2016/08/5000-polish-sentences-sorted-from.html


You will need to update the config.txt for any new language. Rhvoice is quite limited, so I would suggest Pico2wave as an alternative.
