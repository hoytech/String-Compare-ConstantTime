use strict;

use ExtUtils::MakeMaker;

my $preop =
    'perldoc -uT $(VERSION_FROM) | tee $(DISTVNAME)/README.pod > README.pod;' .
    'pod2text README.pod | tee $(DISTVNAME)/README > README';

WriteMakefile(
    NAME              => 'String::Compare::ConstantTime',
    VERSION_FROM      => 'lib/String/Compare/ConstantTime.pm',
    PREREQ_PM         => {
                           'Time::HiRes' => 0,
                         },
    LIBS              => [''],
    DEFINE            => '',
    INC               => '-I.',
    OBJECT            => 'ConstantTime.o',
    dist => {
      PREOP => $preop,
    },
);
