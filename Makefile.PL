use inc::Module::Install;

name 'Filter-PPI';

all_from 'lib/Filter/PPI.pm';

build_requires 'Test::Exception' => '0.27';
build_requires 'Test::More'      => '0.72';

requires 'Exporter'           => '5.58';
requires 'Filter::Util::Call' => '1.0601';
requires 'PPI'                => '1.201';
requires 'Scalar::Util'       => '1.19';

auto_install;

WriteAll;

