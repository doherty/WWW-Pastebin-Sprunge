
use strict;
use warnings;

BEGIN { require 5.008; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'create new pastes on sprunge.us',
  'AUTHOR' => 'Mike Doherty <doherty@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find' => '0',
    'File::Temp' => '0',
    'Test::More' => '0',
    'utf8' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'WWW-Pastebin-Sprunge',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'WWW::Pastebin::Sprunge',
  'PREREQ_PM' => {
    'Carp' => '0',
    'Class::Data::Accessor' => '0',
    'Encode' => '0',
    'HTTP::Request::Common' => '0',
    'LWP::UserAgent' => '0',
    'URI' => '0',
    'overload' => '0'
  },
  'VERSION' => '0.006',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



