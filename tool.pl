#!/usr/bin/env perl

use 5.014.0;
use strict; use warnings; use utf8;

use Data::Dumper;

my $lines = join '',<>;
my $errors = 0;

sub section {
   my ($sign,$command) = @_;
   my $headliner = quotemeta($sign);
   my $match = qr/^([^#\\\$=-\~*&\/%].+?)\n(${headliner}+?)\n/m;
   while($lines =~ $match) {
      my ($title,$underline) = ($1,$2); chomp($title); $title =~ s/(^\s*|\s*$)//g;
      chomp($underline);
      if(abs(length($title)-length($underline))>2) {
        warn "Überschrift: $title?\n";
        $errors++;
      }
      my $subst = "\n\\" . $command . '{' . $title . '} %' . "\n\n";
      $lines =~ s/$match/$subst/;
   }
}

sub itemize {
   my $match = qr/^(-|\*) (.*?)\n\s*\n/sm;
   while($lines =~ $match) {
       my $list = $2;
       $list =~ s/\s*\n\s*/\n/g;
       my @list = grep { !/^(-|\*)$/ } 
           split /\n(-|\*)\s+/,$list;
       my $replace = '\\begin{itemize*}' . "\n\n"; # mdwlist
       $replace .= "\\item " . join("\n\n\\item ",@list) . "\n\n";
       $replace .= '\\end{itemize*}' . "\n\n";
       $lines =~ s/$match/$replace/;
   }
}

section('#','part');
section('+','chapter');
section('=','section');
section('-','subsection');
section('~','subsubsection');
itemize();

say $lines;

exit $errors;
