#! nqp

plan(3);

module ABC {
    sub alpha() { 'alpha' }
    sub &beta() { 'beta' }
    our $gamma := 'gamma';
}

ABC::EXPORT::DEFAULT::alpha := ABC::alpha;
$ABC::EXPORT::DEFAULT::gamma := $ABC::gamma;

my $module := HLL::Compiler.get_module('ABC');
my %exports := HLL::Compiler.get_exports($module);
HLL::Compiler.import(pir::get_namespace__P, %exports);

ok( alpha() eq 'alpha', "imported 'alpha' sub into current namespace" );

our &beta;
ok( !pir::defined(&beta), "didn't import &beta");

our $gamma;
ok( $gamma eq 'gamma', 'did import $gamma');

