
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0,
    "utf8" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "create new pastes on sprunge.us",
  "dist_author" => [
    "Mike Doherty <doherty\@cpan.org>"
  ],
  "dist_name" => "WWW-Pastebin-Sprunge",
  "dist_version" => "0.007",
  "license" => "perl",
  "module_name" => "WWW::Pastebin::Sprunge",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Carp" => 0,
    "Class::Data::Accessor" => 0,
    "Encode" => 0,
    "HTTP::Request::Common" => 0,
    "LWP::UserAgent" => 0,
    "URI" => 0,
    "base" => 0,
    "overload" => 0,
    "perl" => "5.008",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
