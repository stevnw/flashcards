import sys

def process_sentences_to_tsv(language):
    input_filename = f"{language}_sentences.txt"
    output_filename = f"{language}_sentences.tsv"
    
    capitalized_language = language.capitalize()

    with open(input_filename, 'r', encoding='utf-8') as infile, \
            open(output_filename, 'w', encoding='utf-8') as outfile:
        outfile.write(f"{capitalized_language} sentence\tEnglish meaning\tFrequency\n")
        lines = infile.readlines()
        i = 0
        while i < len(lines):
            polish_sentence = lines[i].strip()
            english_meaning = lines[i + 1].strip()
            frequency = lines[i + 2].strip()
            outfile.write(f"{polish_sentence}\t{english_meaning}\t{frequency}\n")
            i += 5

language_input = "russian"
if len(sys.argv) > 1:
    language_input = sys.argv[1]

process_sentences_to_tsv(language_input)
