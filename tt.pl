
my $lines;

sub zitate {
   $lines =~ s/,,/\\tqt{/g;
   $lines =~ s/(''|´´)/}/g;
}

$lines = "
kaafh ,,skdhaudfh´´
asfaoih´´
";

zitate();

say $lines;
