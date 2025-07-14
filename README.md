# flashcards-da
Flashcards with major modifications to allow the use with the tatoeba data &amp; gtts genned audio instead of the tts engine stuff

<img width="510" height="184" alt="image" src="https://github.com/user-attachments/assets/f5335454-26a0-42ef-bf42-46dec3ef45bc" />


Data set included comes from: https://old.reddit.com/r/languagelearning/comments/ywuj8g/100_free_anki_language_decks_xefjords_complete/

I have tried a Tatoeba dataset - pretty much needs to be in the format of

<pre>danish,english,blank,audio_path</pre>

i.e. 

<pre>Velkommen,Welcome,,audio/00001.mp3</pre>

or

<pre>"Hans kone går med ham, hvor end han går.","His wife goes with him wherever he goes.",[95 304 84 15 39 45 131 22 84 = 819],audio/00011.mp3</pre>

<sub> ^This was made using some scripts I wrote that commpare a frequency list against the tatoeba sentences, and then gets it to the lowest amount of phrases needed to cover the set of words. A lot of the sentences were shitty, hence I did not use them in this upload. </sub>

<sub> some of this code in this version is very ugly, but it works... I have not tested this on anything but debian 12 </sub>
