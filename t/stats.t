use String::Compare::ConstantTime qw/equals/;

use strict;

use Time::HiRes qw/time/;

use Test::More skip_all => 1;


__END__

FIXME: finish test


my $f1 = sub {
  my ($i1, $i2) = @_;
  return equals($i1, $i2);
};

my $f2 = sub {
  my ($i1, $i2) = @_;
  return $i1 eq $i2;
};


my $s1 = "a"x1000;
my $s2 = "a"x1000;
my $s3 = "b" . "a"x999;
my $s4 = "a"x99 . "b";
my $s5 = "a"x19 . "b" . "a"x80;


my ($z1, $z2) = gen_timing_data($f2, $s1, $s2, $s3);

my $ttest = new Statistics::TTest;  
$ttest->set_significance(95);
$ttest->load_data($z1,$z2);  
$ttest->output_t_test();   
$ttest->print_t_test();


open(my $fh, '>', 'r1');
print $fh join("\n", @$z1) . "\n";
close($fh);

open($fh, '>', 'r2');
print $fh join("\n", @$z2) . "\n";
close($fh);





ok(1);


sub gen_timing_data {
  my ($cb, $i1, $i2, $i3) = @_;

  my $junk;

  my @r1 = ();
  my @r2 = ();

  for (1..1000) {
    my ($start, $end);

    $start = time;
    for (1..20) {
      $junk = $cb->($i1, $i2);
    }
    $end = time;
    push @r1, $end - $start;

    $start = time;
    for (1..20) {
      $junk = $cb->($i1, $i3);
    }
    $end = time;
    push @r2, $end - $start;

  }

  return ( \@r1, \@r2, );
}
