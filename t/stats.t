use String::Compare::ConstantTime qw/equals/;

use strict;

use Time::HiRes qw/time/;
use Statistics::BoxTest;
use Data::Dumper;

use Test::More tests => 2;


my $data_points = 500;




my $cmp_constanttime = sub {
  my ($i1, $i2) = @_;
  return equals($i1, $i2);
};

my $cmp_perl_eq = sub {
  my ($i1, $i2) = @_;
  return $i1 eq $i2;
};


my $all_a = "a"x1000;
my $last_is_b = "a"x999 . "b";
my $first_is_b = "b" . "a"x999;


## Warm up caches
for (1..2) {
  gen_timing_data($cmp_constanttime, $all_a, $last_is_b, $first_is_b);
}

ok(!is_difference_detected($cmp_constanttime, $all_a, $last_is_b, $first_is_b), 'no difference detected with constanttime');


## Warm up caches
for (1..2) {
  gen_timing_data($cmp_perl_eq, $all_a, $last_is_b, $first_is_b);
}

ok(1 == is_difference_detected($cmp_perl_eq, $all_a, $last_is_b, $first_is_b), 'detected difference with perl eq');



sub is_difference_detected {
  my ($data1, $data2) = gen_timing_data(@_);

  my ($r, $summary) = Statistics::BoxTest::compare(
                        dataset1 => $data1,
                        dataset2 => $data2,
                      );

  diag("RESULT: $r");
  diag("SUMMARY: " . Dumper($summary));

  return $r;
}



sub gen_timing_data {
  my ($cb, $i1, $i2, $i3) = @_;

  my $junk;

  my @r1 = ();
  my @r2 = ();

  for (1..$data_points) {
    my ($start, $end);

    $start = time;
    $junk = $cb->($i1, $i2);
    $end = time;
    push @r1, $end - $start;

    $start = time;
    $junk = $cb->($i1, $i3);
    $end = time;
    push @r2, $end - $start;

  }

  return ( \@r1, \@r2, );
}
