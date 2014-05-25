#!/usr/bin/env perl

use 5.014.0;
use strict; use warnings; use utf8;

use Data::Dumper;

my $lines = join '',<>;
my $errors = 0;

sub escape {
   $lines =~ s/(\$|\&)/\\$1\{\}/g;
}

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

sub quotes {
   my $match = qr/^(\| )(.*?)((\|\: )(.*?))?\n\s*\n/sm;
   while($lines =~ $match) {
       my ($quote,$info) = ($2,$5);
       $quote =~ s/\| //g;
       #my $replace = "\n" . '\\raggedright{\\begin{minipage}[t]{6cm}%' . "\n" . 
       #    '\\raggedleft{\\footnotesize{\\slshape{' . $quote . "}}}\n";
       #if($info) {
       #    $replace .=  . "\n";
       #}
       #$replace .= '\\end{minipage}}%' . "\n\n";
       my $replace = _quote($quote,$info);
       $lines =~ s/$match/$replace/;
   }
}

sub _quote {
  my ($text,$author) = @_;
  my $code = <<__LATEX__;
  \\begin{minipage}{0.9\\textwidth}
  \\vspace{4ex}
  \\begin{flushright}
  \\begin{minipage}[t]{0.55\\textwidth}
  \\raggedleft{\\footnotesize{\\slshape{$text\\noindent}}}%
__LATEX__
  if($author) {
    $code .= "\n\n". '\\vspace{1.8ex}\\footnotesize\\raggedright{' . $author . '}%' . "\n";
  }
  $code .= <<__LATEX__;
  \\end{minipage}
  \\end{flushright}
  \\end{minipage}
__LATEX__
    return $code;
}

escape();
section('#','part');
section('+','chapter');
section('=','section');
section('-','subsection');
section('~','subsubsection');
itemize();
quotes();

say $lines;

exit $errors;
