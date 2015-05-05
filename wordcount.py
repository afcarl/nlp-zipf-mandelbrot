# -*- coding: utf-8 -*-
#!/usr/bin/env python

import sys
import re
import operator

def create_synonyms_dictionary(synonyms_file):
  synonyms = {}
  with open(synonyms_file) as f:
    for line in f:
      words = line.split(', ')
      for word in words[1:]:
        synonyms[word] = words[0]
  return synonyms

def create_words_rank(corpus_file, synonyms):
  words_rank = {}
  with open(corpus_file) as f:
    for line in f:
      words = re.findall(ur"[a-zA-ZżółćęśąźńŻÓŁĆĘŚĄŹŃ]+", line)
      for word in words:
        word = word.strip().lower()
        proper_word = synonyms[word] if word in synonyms else word
        if proper_word in words_rank:
          words_rank[proper_word] += 1
        else:
          words_rank[proper_word] = 1
  return words_rank

if __name__ == '__main__':
  if len(sys.argv) >= 3:
    corpus_file = sys.argv[1]
    synonyms_file = sys.argv[2]

    synonyms = create_synonyms_dictionary(synonyms_file)
    words_rank = create_words_rank(corpus_file, synonyms)

    sorted_words_rank = sorted(words_rank.items(), key=operator.itemgetter(1), reverse=True)

    i = 1
    for item in sorted_words_rank:
      print(str(i) + "," + item[0] + "," + str(item[1]))
      i += 1

  else:
    print("python wordcount.py [corpus] [synonyms]")
