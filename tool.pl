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

section('=','section');
section('-','subsection');
section('~','subsubsection');

say $lines;

exit $errors;
