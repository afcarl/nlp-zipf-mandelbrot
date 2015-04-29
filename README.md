Natural Language Processing - Create Zipf and Mandelbrot statistics for corpus
============

Run:
~~~
pip install -r requirements.txt
python -m wordcount test/potop.txt test/odm.txt > stats.txt
~~~

Please run `chart.r` file to generate chart and some numbers.

Sample chart:

![Zipf-Mandelbrot chart](/test/Rplot.png?raw=true)

Other stats:
~~~
Number of words which cover 50% of corpus: 145
Number of hapax legomena: 7716
~~~
