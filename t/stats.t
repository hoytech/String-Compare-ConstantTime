use String::Compare::ConstantTime qw/equals/;

use strict;

use FindBin;
use Time::HiRes qw/time/;
use File::Temp;

use Test::More tests => 2;


my $data_points = 25;
my $iters = 20;
my $confidence = 95;


my $ministat_bin = "$FindBin::Bin/lib/ministat.pl";



my $cmp_constanttime = sub {
  my ($i1, $i2) = @_;
  return equals($i1, $i2);
};

my $cmp_perl_eq = sub {
  my ($i1, $i2) = @_;
  return $i1 eq $i2;
};


ok(!is_difference_detected($cmp_constanttime, "a"x1000, "a"x999 . "b", "b" . "a"x999), 'no difference detected with constanttime');
ok(is_difference_detected($cmp_perl_eq, "a"x1000, "a"x999 . "b", "b" . "a"x999), 'detected difference with perl eq');



sub is_difference_detected {
  my ($data1, $data2) = gen_timing_data(@_);

  my ($fh1, $filename1) = File::Temp::tempfile();
  my ($fh2, $filename2) = File::Temp::tempfile();

  print $fh1 "$_\n" for @$data1;
  print $fh2 "$_\n" for @$data2;

  close($fh1);
  close($fh2);

  my $ministat_output = `$ministat_bin -c $confidence $filename1 $filename2`;

  unlink($filename1);
  unlink($filename2);

  if ($ministat_output =~ /No difference proven/) {
    return 0;
  } elsif ($ministat_output =~ /Difference at/) {
    return 1;
  } else {
    die "couldn't parse ministat output";
  }
}



sub gen_timing_data {
  my ($cb, $i1, $i2, $i3) = @_;

  my $junk;

  my @r1 = ();
  my @r2 = ();

  for (1..$data_points) {
    my ($start, $end);

    $start = time;
    for (1..$iters) {
      $junk = $cb->($i1, $i2);
    }
    $end = time;
    push @r1, $end - $start;

    $start = time;
    for (1..$iters) {
      $junk = $cb->($i1, $i3);
    }
    $end = time;
    push @r2, $end - $start;

  }

  return ( \@r1, \@r2, );
}
