use strict;

use ExtUtils::MakeMaker;

my $preop =
    'perldoc -uT $(VERSION_FROM) | tee $(DISTVNAME)/README.pod > README.pod;' .
    'pod2text README.pod | tee $(DISTVNAME)/README > README';

my %args = (
    NAME              => 'String::Compare::ConstantTime',
    VERSION_FROM      => 'lib/String/Compare/ConstantTime.pm',
    PREREQ_PM         => {
                         },
    LIBS              => [''],
    DEFINE            => '',
    INC               => '-I.',
    OBJECT            => 'ConstantTime.o',
    LICENSE           => 'perl',
    dist => {
      PREOP => $preop,
    },
);

my $eummv = eval ($ExtUtils::MakeMaker::VERSION);
if ($eummv >= 6.45) {
    $args{META_MERGE} = {
        resources => {
            repository => 'git://github.com/hoytech/String-Compare-ConstantTime.git',
            bugtracker => 'https://github.com/hoytech/String-Compare-ConstantTime/issues',
        },
    };
}

WriteMakefile(%args);
