#!/usr/bin/perl 
use strict;
use warnings;
# by jmxia
#The script is to get the targeted seq of assigned length
if(@ARGV !=5){
print "Usage:perl $0 in.fasta id start end out.fasta\n";
}


my %seq_hash;
open (IN,$ARGV[0])||die $!;
my $title;
while (<IN>){
  chomp;
  if (/>/){
    my @array = split /\s+/,$_;
    my $id = $array[0];
    $id=~ s/^>//;
    $title=$id;
  }
  else {
    $seq_hash{$title} .=$_;
  }
}
close IN;

my ($l,$scaf,$start,$end,$sequence,$out_file,$seq);
($scaf,$start,$end) = ($ARGV[1],$ARGV[2],$ARGV[3]);
$sequence = $seq_hash{$scaf};
if ($start<$end){
  $seq= substr($sequence,($start-1),($end-$start+1));
  $l = length($seq);
  print "The length of obttained sequence is:$l\n";
  $out_file=$ARGV[4];
  open (OUT,">>$out_file")||die$!;
  print OUT ">$scaf\_$start\_$end\n$seq\n";
  close OUT;
}
else{
  $seq= reverse(substr($sequence,($end-1),($start-$end+1)));
  $l = length($seq);
  print "The length of obttained sequence is:$l\n";
  $out_file=$ARGV[4];
  open (OUT,">>$out_file")||die$!;
  print OUT ">$scaf\_$start\_$end\n$seq\n";
  close OUT;
}
