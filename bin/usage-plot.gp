#!/usr/bin/env -S gnuplot --persist -c
# Plot memory and CPU usage over time. Usage:
#  usage-plot.gp <input file> [<output .png file>]
# where the input file has the columns `<unix time> <memory, with m/g suffix> <% cpu>`
# To create the input file, use mem-usage.sh
#
# Credits:
# https://gist.githubusercontent.com/holyjak/1b58dedae3207b4a56c9abcde5f3fdb5/raw/f86691c72228f86dbe080463ddb4a3f5d07bfe20/plot-usage.gp

# Arguments:
infile=ARG1
outfile=ARG2
set term png
set title 'Memory, CPU usage from ' . infile
set xdata time
set timefmt "%s"
set xlabel "Time [[hh:]mm:ss]"
set ylabel "Memory usage"
set format y '%.1s%cB'

set tics out
set autoscale y

# Credit: Christoph @ https://stackoverflow.com/a/52822256/204205
resolveUnit(s)=(pos=strstrt("KMGTP",s[strlen(s):*]), real(s)*(1024**pos))

if (exists("outfile") && strlen(outfile) > 0) {
    print "Outputting to the file ", outfile
    set term png # 640,480
    set output outfile
}

# Styling
set style line 1 linewidth 2 linecolor 'blue'
#set xtics font ", 10"
set tics font ", 10"
set xtics rotate 60 # put label every 60s, make vertical so they don't clash in .png if too many

plot infile using 1:(resolveUnit(stringcolumn(2))) with linespoints title "memory" linestyle 1
