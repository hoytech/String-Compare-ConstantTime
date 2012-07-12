#!/usr/bin/perl

use strict;
use warnings;

my $NSTUDENT = 100;		# Number of rows in @student
my $NCONF    = 6;		# Number of confidence intervals

               # 80%     90%     95%     98%     99%     99.5%
my @student = ([ 1.282,  1.645,  1.960,  2.326,  2.576,  3.090   ],
	       [ 3.078,  6.314,  12.706, 31.821, 63.657, 318.313 ],
	       [ 1.886,  2.920,  4.303,  6.965,  9.925,  22.327  ],
	       [ 1.638,  2.353,  3.182,  4.541,  5.841,  10.215  ],
	       [ 1.533,  2.132,  2.776,  3.747,  4.604,  7.173   ],
	       [ 1.476,  2.015,  2.571,  3.365,  4.032,  5.893   ],
	       [ 1.440,  1.943,  2.447,  3.143,  3.707,  5.208   ],
	       [ 1.415,  1.895,  2.365,  2.998,  3.499,  4.782   ],
	       [ 1.397,  1.860,  2.306,  2.896,  3.355,  4.499   ],
	       [ 1.383,  1.833,  2.262,  2.821,  3.250,  4.296   ],
	       [ 1.372,  1.812,  2.228,  2.764,  3.169,  4.143   ],
	       [ 1.363,  1.796,  2.201,  2.718,  3.106,  4.024   ],
	       [ 1.356,  1.782,  2.179,  2.681,  3.055,  3.929   ],
	       [ 1.350,  1.771,  2.160,  2.650,  3.012,  3.852   ],
	       [ 1.345,  1.761,  2.145,  2.624,  2.977,  3.787   ],
	       [ 1.341,  1.753,  2.131,  2.602,  2.947,  3.733   ],
	       [ 1.337,  1.746,  2.120,  2.583,  2.921,  3.686   ],
	       [ 1.333,  1.740,  2.110,  2.567,  2.898,  3.646   ],
	       [ 1.330,  1.734,  2.101,  2.552,  2.878,  3.610   ],
	       [ 1.328,  1.729,  2.093,  2.539,  2.861,  3.579   ],
	       [ 1.325,  1.725,  2.086,  2.528,  2.845,  3.552   ],
	       [ 1.323,  1.721,  2.080,  2.518,  2.831,  3.527   ],
	       [ 1.321,  1.717,  2.074,  2.508,  2.819,  3.505   ],
	       [ 1.319,  1.714,  2.069,  2.500,  2.807,  3.485   ],
	       [ 1.318,  1.711,  2.064,  2.492,  2.797,  3.467   ],
	       [ 1.316,  1.708,  2.060,  2.485,  2.787,  3.450   ],
	       [ 1.315,  1.706,  2.056,  2.479,  2.779,  3.435   ],
	       [ 1.314,  1.703,  2.052,  2.473,  2.771,  3.421   ],
	       [ 1.313,  1.701,  2.048,  2.467,  2.763,  3.408   ],
	       [ 1.311,  1.699,  2.045,  2.462,  2.756,  3.396   ],
	       [ 1.310,  1.697,  2.042,  2.457,  2.750,  3.385   ],
	       [ 1.309,  1.696,  2.040,  2.453,  2.744,  3.375   ],
	       [ 1.309,  1.694,  2.037,  2.449,  2.738,  3.365   ],
	       [ 1.308,  1.692,  2.035,  2.445,  2.733,  3.356   ],
	       [ 1.307,  1.691,  2.032,  2.441,  2.728,  3.348   ],
	       [ 1.306,  1.690,  2.030,  2.438,  2.724,  3.340   ],
	       [ 1.306,  1.688,  2.028,  2.434,  2.719,  3.333   ],
	       [ 1.305,  1.687,  2.026,  2.431,  2.715,  3.326   ],
	       [ 1.304,  1.686,  2.024,  2.429,  2.712,  3.319   ],
	       [ 1.304,  1.685,  2.023,  2.426,  2.708,  3.313   ],
	       [ 1.303,  1.684,  2.021,  2.423,  2.704,  3.307   ],
	       [ 1.303,  1.683,  2.020,  2.421,  2.701,  3.301   ],
	       [ 1.302,  1.682,  2.018,  2.418,  2.698,  3.296   ],
	       [ 1.302,  1.681,  2.017,  2.416,  2.695,  3.291   ],
	       [ 1.301,  1.680,  2.015,  2.414,  2.692,  3.286   ],
	       [ 1.301,  1.679,  2.014,  2.412,  2.690,  3.281   ],
	       [ 1.300,  1.679,  2.013,  2.410,  2.687,  3.277   ],
	       [ 1.300,  1.678,  2.012,  2.408,  2.685,  3.273   ],
	       [ 1.299,  1.677,  2.011,  2.407,  2.682,  3.269   ],
	       [ 1.299,  1.677,  2.010,  2.405,  2.680,  3.265   ],
	       [ 1.299,  1.676,  2.009,  2.403,  2.678,  3.261   ],
	       [ 1.298,  1.675,  2.008,  2.402,  2.676,  3.258   ],
	       [ 1.298,  1.675,  2.007,  2.400,  2.674,  3.255   ],
	       [ 1.298,  1.674,  2.006,  2.399,  2.672,  3.251   ],
	       [ 1.297,  1.674,  2.005,  2.397,  2.670,  3.248   ],
	       [ 1.297,  1.673,  2.004,  2.396,  2.668,  3.245   ],
	       [ 1.297,  1.673,  2.003,  2.395,  2.667,  3.242   ],
	       [ 1.297,  1.672,  2.002,  2.394,  2.665,  3.239   ],
	       [ 1.296,  1.672,  2.002,  2.392,  2.663,  3.237   ],
	       [ 1.296,  1.671,  2.001,  2.391,  2.662,  3.234   ],
	       [ 1.296,  1.671,  2.000,  2.390,  2.660,  3.232   ],
	       [ 1.296,  1.670,  2.000,  2.389,  2.659,  3.229   ],
	       [ 1.295,  1.670,  1.999,  2.388,  2.657,  3.227   ],
	       [ 1.295,  1.669,  1.998,  2.387,  2.656,  3.225   ],
	       [ 1.295,  1.669,  1.998,  2.386,  2.655,  3.223   ],
	       [ 1.295,  1.669,  1.997,  2.385,  2.654,  3.220   ],
	       [ 1.295,  1.668,  1.997,  2.384,  2.652,  3.218   ],
	       [ 1.294,  1.668,  1.996,  2.383,  2.651,  3.216   ],
	       [ 1.294,  1.668,  1.995,  2.382,  2.650,  3.214   ],
	       [ 1.294,  1.667,  1.995,  2.382,  2.649,  3.213   ],
	       [ 1.294,  1.667,  1.994,  2.381,  2.648,  3.211   ],
	       [ 1.294,  1.667,  1.994,  2.380,  2.647,  3.209   ],
	       [ 1.293,  1.666,  1.993,  2.379,  2.646,  3.207   ],
	       [ 1.293,  1.666,  1.993,  2.379,  2.645,  3.206   ],
	       [ 1.293,  1.666,  1.993,  2.378,  2.644,  3.204   ],
	       [ 1.293,  1.665,  1.992,  2.377,  2.643,  3.202   ],
	       [ 1.293,  1.665,  1.992,  2.376,  2.642,  3.201   ],
	       [ 1.293,  1.665,  1.991,  2.376,  2.641,  3.199   ],
	       [ 1.292,  1.665,  1.991,  2.375,  2.640,  3.198   ],
	       [ 1.292,  1.664,  1.990,  2.374,  2.640,  3.197   ],
	       [ 1.292,  1.664,  1.990,  2.374,  2.639,  3.195   ],
	       [ 1.292,  1.664,  1.990,  2.373,  2.638,  3.194   ],
	       [ 1.292,  1.664,  1.989,  2.373,  2.637,  3.193   ],
	       [ 1.292,  1.663,  1.989,  2.372,  2.636,  3.191   ],
	       [ 1.292,  1.663,  1.989,  2.372,  2.636,  3.190   ],
	       [ 1.292,  1.663,  1.988,  2.371,  2.635,  3.189   ],
	       [ 1.291,  1.663,  1.988,  2.370,  2.634,  3.188   ],
	       [ 1.291,  1.663,  1.988,  2.370,  2.634,  3.187   ],
	       [ 1.291,  1.662,  1.987,  2.369,  2.633,  3.185   ],
	       [ 1.291,  1.662,  1.987,  2.369,  2.632,  3.184   ],
	       [ 1.291,  1.662,  1.987,  2.368,  2.632,  3.183   ],
	       [ 1.291,  1.662,  1.986,  2.368,  2.631,  3.182   ],
	       [ 1.291,  1.662,  1.986,  2.368,  2.630,  3.181   ],
	       [ 1.291,  1.661,  1.986,  2.367,  2.630,  3.180   ],
	       [ 1.291,  1.661,  1.986,  2.367,  2.629,  3.179   ],
	       [ 1.291,  1.661,  1.985,  2.366,  2.629,  3.178   ],
	       [ 1.290,  1.661,  1.985,  2.366,  2.628,  3.177   ],
	       [ 1.290,  1.661,  1.985,  2.365,  2.627,  3.176   ],
	       [ 1.290,  1.661,  1.984,  2.365,  2.627,  3.175   ],
	       [ 1.290,  1.660,  1.984,  2.365,  2.626,  3.175   ],
	       [ 1.290,  1.660,  1.984,  2.364,  2.626,  3.174   ]
	      );

package dataset;

use List::Util qw(max min);
use Term::ANSIColor;

sub new {
    my $class = shift;
    my %opts  = @_;

    my $self = {};
    $self->{data} = [];
    $self->{sy}   = undef;
    $self->{syy}  = undef;
    $self->{name} = undef;

    return bless $self, $class;
}

sub AddPoint {
    my $self = shift;
    my $a    = shift;

    $self->{sy} += $a;
    $self->{syy} += $a * $a;

    push(@{ $self->{data} }, $a);

    return;
}

sub name {
    return shift->{name};
}

sub Data {
    my $self = shift;
    return sort { $a <=> $b } @{$self->{data}};
}

sub Min {
    my $self = shift;

    return min(@{$self->{data}});
}

sub Max {
    my $self = shift;

    return max(@{$self->{data}});
}

sub Mean {
    my $self = shift;

    return $self->{sy} / @{$self->{data}};
}

sub Median {
    my $self = shift;
    my($i, $even);

    my @sorted = $self->Data();

    if((@sorted % 2) == 1) {
	$i = (@sorted / 2);
	$even = 0;
    } else {
	$i = @sorted / 2;
	$even = 1;
    }

    if($even) {
	return ($sorted[$i -1 ] + $sorted[$i]) / 2;
    } else {
	return $sorted[$i];
    }
}

sub Var {
    my $self = shift;

    return ($self->{syy} - $self->{sy} * $self->{sy} / @{$self->{data}}) / (@{$self->{data}} - 1.0);
}

sub Stddev {
    my $self = shift;

    return sqrt($self->Var());
}

sub n {
    my $self = shift;
    return scalar @{$self->{data}};
}

sub ReadSet {
    my $self = shift;
    my $file = shift;

    open(my $fh, '<', $file) or die("$file: $!\n");
    $self->{name} = $file;
    while(<$fh>) {
	chomp;
	next if /^#/;
	$self->AddPoint($_);
    }
}

package plot;

use Term::ANSIColor;

my @colors  = qw(red blue yellow magenta cyan white black);

sub new {
    my $class = shift;
    my %opts  = @_;

    my $self  = {};
    $self->{$_} = undef foreach qw(min max span width x0 dx height
				   separate_bars);

    $self->{symbols}       = $opts{symbols};
    $self->{width}         = $opts{width};
    $self->{separate_bars} = $opts{separate};
    $self->{height}        = 0;
    $self->{min}           = 999e99;
    $self->{max}           = -999e99;

    $self->{data} = [];
    $self->{bar}  = [];

    return bless $self, $class;
}

sub AdjPlot {
    my $self = shift;
    my $a    = shift;

    $self->{min} = $a if $a < $self->{min};
    $self->{max} = $a if $a > $self->{max};

    $self->{span} = $self->{max} - $self->{min};
    $self->{dx} = $self->{span} / ($self->{width} - 3.0);
    $self->{x0} = $self->{min} - 0.5 * $self->{dx};
}

sub DimPlot {
    my $self = shift;
    my $ds   = shift;

    $self->AdjPlot($ds->Min());
    $self->AdjPlot($ds->Max());
    $self->AdjPlot($ds->Mean() - $ds->Stddev());
    $self->AdjPlot($ds->Mean() + $ds->Stddev());
}

sub PlotSet {
    my $self  = shift;
    my $ds    = shift;
    my $val   = shift;
    my $merge = shift;

    my($i, $j, $m, $x, $bar);

    return if $self->{span} == 0;

    if($self->{separate_bars}) {
	$bar = $val - 1;
    } else {
	$bar = 0;
    }

    $m = 1;
    $i = -1;
    $j = 0;

    foreach my $p ($ds->Data()) {
	$x = int(($p - $self->{x0}) / $self->{dx});
	if($x == $i) {
	    $j++;
	    $m = $j if $j > $m;
	} else {
	    $j = 1;
	    $i = $x;
	}
    }

    $m++;
    $self->{height} = $m;
    $i = -1;
    foreach my $p ($ds->Data()) {
	$x = int(($p - $self->{x0}) / $self->{dx});
	if($x == $i) {
	    $j++;
	} else {
	    $j = 1;
	    $i = $x;
	}
	if($merge) {
	    $self->{data}[$j * $self->{width} + $x] |= $val;
	} else {
	    $self->{data}[$j * $self->{width} + $x] = $val;
	}
    }

    $x = (($ds->Mean() - $ds->Stddev()) - $self->{x0}) / $self->{dx};
    $m = (($ds->Mean() + $ds->Stddev()) - $self->{x0}) / $self->{dx};
    $self->{bar}[$bar][$m] = '|';
    $self->{bar}[$bar][$x] = '|';
    foreach my $i ($x + 1 .. $m - 1) {
	$self->{bar}[$bar][$i] = '_' unless defined $self->{bar}[$bar][$i];
    }
    $x = ($ds->Median() - $self->{x0}) / $self->{dx};
    $self->{bar}[$bar][$x] = 'M';
    $x = ($ds->Mean() - $self->{x0}) / $self->{dx};
    $self->{bar}[$bar][$x] = ':';
}

my $plot_color = 'green on_black';

sub symbol {
    my $self = shift;
    my $i    = shift;

    return $self->{symbols}[$i % @{ $self->{symbols} }];
}

sub LegendPlot {
    my $self  = shift;
    my @ds    = @{ +shift };
    my $width = shift;
    my $color = shift;

    foreach my $i (0 .. $#ds) {
	print color $colors[$i] . ' on_black' if $color;
	printf("%s %-*s", $self->symbol($i), $width - 2, $ds[$i]->name());
	print color 'reset' if $color;
	print "\n";
    }
}

sub DumpPlot {
    my $self  = shift;
    my @ds    = @{ +shift };
    my $width = shift;
    my $color = shift;

    my($i, $j, $k);

    if($self->{span} == 0) {
	print "[no plot, span is zero width]\n";
	return;
    }

    print color 'white on_black' if $color;
    printf("%-*s", $width, ": = Mean");
    print color 'reset' if $color;
    print "\n";
    print color 'white on_black' if $color;
    printf("%-*s", $width, "M = Median");
    print color 'reset' if $color;
    print "\n";

    print color $plot_color if $color;
    print '+';
    print '-' x ($self->{width} - 2);
    print "+";

    print color 'reset' if $color;
    print "\n";

    foreach my $i (1 .. $self->{height} - 1) {
	print color $plot_color if $color;
	print '|';
	
	foreach my $j (0 .. $self->{width} - 3) {
	    $k = $self->{data}[($self->{height} - $i) * $self->{width} + $j];
	    print ' ' and next unless defined $k;
	    print color $colors[$k - 1] . ' on_black' if $color;
	    print $self->symbol($k - 1);
	}
	
	print color $plot_color if $color;
	print '|';
	print color 'reset' if $color;
	print "\n";
    }

    foreach my $i (0 .. @{$self->{bar}} - 1) {
	print color $plot_color if $color;
	print '|';

	print color $colors[$i] . ' on_black' if $color;
	foreach my $j (0 .. $self->{width} - 3) {
	    $k = $self->{bar}[$i][$j];
	    $k = ' ' unless defined $k;
	    if($k eq ':' or $k eq 'M') {
		print color 'white on_black' if $color;
		print $k;
		print color $colors[$i] . ' on_black' if $color;
		
	    } else {
		print $k;
	    }
	}

	print color $plot_color if $color;
	print '|';
	print color 'reset' if $color;
	print "\n";
    }

    print color $plot_color if $color;
    print '+';
    print '-' x ($self->{width} - 2);
    print '+';
    print color 'reset' if $color;
    print "\n";
}

sub VitalsHead {
    my $self  = shift;
    my $width = shift;
    my $color = shift;

    print color 'white on_black' if $color;
    my $line = sprintf("    N           Min           Max        Median          Mean        Stddev");

    print $self->_pad($line, ' ', $width);

    print color 'reset' if $color;
    print "\n";
}

sub _pad {
    my $self     = shift;
    my $line     = shift;
    my $pad_char = shift;
    my $length   = shift;

    $line .= $pad_char x ($length - length($line));

    return $line;
}

sub Vitals {
    my $self  = shift;
    my $ds    = shift;
    my $flag  = shift;
    my $width = shift;
    my $color = shift;

    print color $colors[$flag] . ' on_black' if $color;
    my $line = sprintf("%s %3d %13.8g %13.8g %13.8g %13.8g %13.8g",
		       $self->symbol($flag),
		       scalar $ds->n(), $ds->Min(), $ds->Max(),
		       $ds->Median(), $ds->Mean(), $ds->Stddev());

    print $self->_pad($line, ' ', $width);
    print color 'reset' if $color;
    print "\n";

}

sub Relative {
    my($self, $ds, $rs, $confidx, $conf, $width, $color) = @_;

    my($spool, $s, $d, $e, $t, $i, $c);

    $i = $ds->n() + $rs->n() - 2;
    if($i > $NSTUDENT) {
	$t = $student[0][$confidx];
    } else {
	$t = $student[$i][$confidx];
    }

    $spool = ($ds->n() - 1) * $ds->Var() + ($rs->n() - 1) * $rs->Var();
    $spool /= $ds->n() + $rs->n() - 2;
    $spool = sqrt($spool);
    $s = $spool * sqrt(1.0 / $ds->n() + 1.0 / $rs->n());
    $d = $ds->Mean() - $rs->Mean();
    $e = $t * $s;

    if(abs($d) > $e) {
	print color 'white on_black' if $color;
	print $self->_pad(sprintf("Difference at %.1f%% confidence", $conf),
			  ' ', $width);
	print color 'reset' if $color;
	print "\n";

	print color 'white on_black' if $color;
	print $self->_pad(sprintf("        %g +/- %g", $d, $e), ' ', $width);
	print color 'reset' if $color;
	print "\n";

	print color 'white on_black' if $color;
	print $self->_pad(sprintf("        %g%% +/- %g%%",
				  $d * 100 / $rs->Mean(),
				  $e * 100 / $rs->Mean()),
			  ' ', $width);
	print color 'reset' if $color;
	print "\n";

	print color 'white on_black' if $color;
	print $self->_pad(sprintf("        (Student's t, pooled s = %g)",
				  $spool),
			  ' ', $width);
	print color 'reset' if $color;
	print "\n";
    } else {
	print color 'white on_black' if $color;
	print $self->_pad(sprintf("No difference proven at %.1f%% confidence",
				  $conf),
			  ' ', $width);
	print color 'reset' if $color;
	print "\n";
    }
    print color 'reset' if $color;
}

package main;

use Getopt::Long;
use Pod::Usage;
use Term::ANSIColor;

my @symbols = qw(x   +    *      %       -    @     O    );

my %opts     = (ansi            => 0,
		confidence      => 95,
		merge           => 0,
		separate_bars   => 0,
		symbols         => 'x+*%-@O',
		width           => 76,
		help            => 0,
		);

my %opt_spec = ('a|ansi'          => \$opts{ansi},
		'c|confidence=f'  => \$opts{confidence},
		'm|merge-symbols' => \$opts{merge},
		's|separate-bars' => \$opts{separate_bars},
		'symbols=s'       => \$opts{symbols},
		'w|width=i'       => \$opts{width},
		'help'            => \$opts{help},
	       );

my %confidences = (80 => 0, 90   => 1, 95 => 2, 98 => 3,
		   99 => 4, 99.5 => 5);

main();
exit;

sub main {
    GetOptions(%opt_spec);
    pod2usage(-verbose => 1) if $opts{help};

    if(! exists $confidences{$opts{confidence}}) {
	die "Confidence argument must be one of ",
	  join(', ', sort keys %confidences), ".\n";
    }

    $opts{symbols} = [ split('', $opts{symbols}) ];

    my @ds = ();

    my($a, $p, $c, $i);

    foreach my $file (@ARGV) {
	my $ds = dataset->new();
	$ds->ReadSet($file);
	push @ds, $ds;
    }


    my $plot = plot->new(width    => $opts{width},
			 separate => $opts{separate_bars},
			 symbols  => $opts{symbols});

    if($opts{width} > 1) {
	$plot->DimPlot($_) foreach @ds;
	
	foreach my $i (0 .. $#ds) {
	    $plot->PlotSet($ds[$i], $i + 1, $opts{merge});
	}
    }

    $plot->LegendPlot(\@ds, $opts{width}, $opts{ansi});
    $plot->DumpPlot(\@ds, $opts{width}, $opts{ansi})
      unless $opts{width} < 2;

    $plot->VitalsHead($opts{width}, $opts{ansi});
    $plot->Vitals($ds[0], 0, $opts{width}, $opts{ansi});

    foreach my $i (1 .. $#ds) {
	$plot->Vitals($ds[$i], $i, $opts{width}, $opts{ansi});
	$plot->Relative($ds[$i], $ds[0], $confidences{$opts{confidence}},
			$opts{confidence}, $opts{width}, $opts{ansi});
    }
}

__END__

=head1 NAME

ministat - Plot Student's T distribution for two or more datasets

=head1 SYNOPSIS

  ministat [-a] [-m] [-s]
           [-c conf] [-w width] [--symbols string]
           file1 file2 [file3 ... file8]
  ministat --help

=head1 DESCRIPTION

C<ministat> reads two or more datafiles and applies Student's T test
to determine whether the mean values of the data sets are
statistically significant from one another.

This is particularly useful for comparing results when preparing a
benchmark.

=head1 OPTIONS

=over

=item -a, or --ansi

Use ANSI terminal escape sequences to plot the results in color.

=item -c, or --confidence

Specifies the confidence interval to use when determining whether the
results are statistically significant.

Valid values are C<80>, C<90>, C<95>, C<98>, C<99>, and C<99.5>.

The default value is C<95>.

=item -m, or --merge-symbols

If specified, changes how datapoints that overlap are plotted.

Without this option, the symbol for the last datapoint is plotted.

With this option, the dataset numbers that each datapoint comes from
are ORd together, and then plotted use the symbol for the resulting
dataset number..

An example may make this clearer.  The first three symbols are C<x>,
C<+>, and C<*>.  Suppose you specifiy two datasets to C<ministat>.
Dataset 1 will be plotted with symbol 1 (C<x>), dataset two with
symbol 2 (C<+>).  If any of the points overlap then symbol C<1 | 2>
will be used.  C<1 | 2 == 3>, hence C<*> will be printed for the
overlapping symbols.

=item -s, or --separate-bars

If specified, each dataset's I<range> bar will be plotted on a separate
line.  Without this option the range bars may overprint one another.

This option increases the vertical height of plots.

=item --symbols

Specifies a list of symbols to use when plotting the datasets.  The
first dataset is assigned the first symbol, the second dataset is
assigned the second symbol, and so on.

If you supply more datasets than symbols then the datasets will wrap
around through the available symbols.

For example, given C<--symbols x+*>, and four datasets, the first
dataset will use C<x>, the second will use C<+>, the third will use
C<*>, and the fourth will use C<x>.  In this instance the C<-a> (or
C<--ansi>) option, to use colour to distinguish the datasets, may be
useful.

The default symbol list is C<x+*%-@O>.

=item -w, or --width

Specifies the width of the plot area in columns.  The default value is
C<76>.

Note that this does not affect the width of the data area printed below
the plot area.

Specifying a width less than 2 will disable printing the plot.

=back

=head1 USAGE

Prepare your data files.  Each file should contain numerical data, one
reading per line.  You need at least three data points in each data
set, but the more you have the better the results you get.

Run C<ministat>, listing both files on the command line.  You will see
output similar to the following.

  x file1
  + file2
  : = Mean
  M = Median
  +---------------------------------------------------------------------+
  |                                                          +          |
  |                               x                          +         +|
  |x                    x         x          x               +         +|
  |         |_______________:_____M_________|              |_M___:____| |
  +---------------------------------------------------------------------+
      N           Min         Max      Median        Mean        Stddev
  x   5         0.133       0.137       0.136      0.1354  0.0015165751
  +   5         0.139        0.14       0.139      0.1394 0.00054772256
  Difference at 95.0% confidence
          0.004 +/- 0.00166288
          2.95421% +/- 1.22812%
          (Student's t, pooled s = 0.00114018)

The first four lines are the legend.  This indicates that an C<x> in
the plot area is from F<file1>, a C<+> is from F<file2>.  Following
that is a reminder for the Mean and Median symbols.

The next section is the plot area.  This shows the relative location of
the datapoints from each file.

The bottom line of the plot area shows additional information.

The Mean and Median of each dataset are identified.  The vertical bars
(C<|>) indicate the range of Mean - Stddev and Mean + Stddev for
each dataset.

Below the plot is another legend, followed by the pertinent values
derived from each dataset.

Finally there is an explanation of the differences between each dataset.
In this example the values in the second dataset are 0.004 larger than
the values in the first, which is a difference of 2.95421%.

This is a small difference, but it's measurable, and you can be 95%
confident that it's a real difference, and not just down to random noise
in the numbers.

Here is an example where there is no statistical difference.

  x file1
  + file2
  : Mean
  M Median
  +---------------------------------------------------------------------+
  |x           +   x+     x            x   x            +          ++   |
  |       |_________|_____:M______________|__:__________M______________||
  +---------------------------------------------------------------------+
      N           Min           Max    Median        Mean        Stddev
  x   5         36060         36138     36107     36105.6     31.165686
  +   5         36084         36187     36163     36142.6     49.952978
  No difference proven at 95.0% confidence

As you can see the bars have overlapped because the data in the
datasets overlapped.  Use the C<--separate-bars> option to place each
bar on a separate line.  The plot would then look like this:

  x file1
  + file2
  : Mean
  M Median
  +---------------------------------------------------------------------+
  |x           +   x+     x            x   x            +          ++   |
  |       |_______________:M______________|                             |
  |                 |________________________:__________M______________||
  +---------------------------------------------------------------------+
      N           Min           Max    Median        Mean        Stddev
  x   5         36060         36138     36107     36105.6     31.165686
  +   5         36084         36187     36163     36142.6     49.952978
  No difference proven at 95.0% confidence

C<ministat> can plot up to many different datasets, although the display
may get crowded.

  x file1
  + file2
  * file3
  : = Mean
  M = Median
  +---------------------------------------------------------------------+
  |                           *    *                                    |
  |                           *    *                                    |
  |x    x   x    x   x    *   *    *            +    +   +    +   +     |
  |x    x   x    x   x    *   *    *    *       +    +   +    +   +    +|
  |   |______:___M___|      |___:__M|              |_______:__M___|     |
  +---------------------------------------------------------------------+
      N           Min           Max    Median        Mean       Stddev
  x  11             1             6         4   3.2727273     1.6787441
  +  11            12            17        15   14.272727     1.6787441
  Difference at 95.0% confidence
          11 +/- 1.4932
          336.111% +/- 45.6255%
          (Student's t, pooled s = 1.67874)
  *  11             6             9         8   7.3636364    0.92441628
  Difference at 95.0% confidence
          4.09091 +/- 1.20535
          125% +/- 36.8301%
          (Student's t, pooled s = 1.35512)

Note that there are now two C<Difference> sections in the statistical
report at the bottom.  Each report compares the current dataset to
the first dataset, so in this case the third dataset (which appears
in the middle of the other two in the plot area is being compared to
the first (hence the smaller differences).

Also note that since the range bars do not overlap there was no need
to use the C<-s> option.

=head1 HISTORY

C<ministat> is based very heavily on a C implementation by
Poul-Henning Kamp C<< <phk@FreeBSD.org> >>.  His code can be
seen at
L<http://www.freebsd.org/cgi/cvsweb.cgi/src/tools/tools/ministat/>.

That implementation required some FreeBSD specific header files which
precluded running it on Solaris (or other environments that lack a
compiler).  It was easier to port the program to Perl than deal with
the lack of header files and compiler.

There are many fine modules on CPAN that deal with statistics and
Student's tests.  This program uses none of them -- again, it being
easier to reimplement the little functionality that was needed in this
program, rather than require the user to drag in a number of external
dependencies.

=head1 LICENSE

The original C<ministat> carries this license.

  /*
   * -------------------------------------------------------------------
   * "THE BEER-WARE LICENSE" (Revision 42):
   * <phk@FreeBSD.ORG> wrote this file.  As long as you retain this
   * notice you can do whatever you want with this stuff. If we meet
   * some day, and you think this stuff is worth it, you can buy me a
   * beer in return.  Poul-Henning Kamp
   *--------------------------------------------------------------------
   *
   */

That works for me.  Accordingly, you can do whatever you want with this
code.  If we meet some day, and you think it's worth it, you can buy me
a gin and tonic.

=head1 AUTHORS

Copyright 2006 by Nik Clayton C<< <nikc@cpan.org> >>.
