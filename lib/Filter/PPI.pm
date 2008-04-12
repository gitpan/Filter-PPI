package Filter::PPI;

use Carp;
use Filter::Util::Call;
use PPI::Document;
use Scalar::Util;

use strict;
use warnings;

our $VERSION = '0.00_01';

sub import {
  my $caller = caller;

  {
    no warnings qw/redefine/;
    no strict qw/refs/;

    *{$caller.'::import'} = sub {
      my ($class,@args) = @_;

      use strict;
      use warnings;

      filter_add (sub {
          my $status;

          Carp::confess "Filter error ($status) while reading source"
            if ($status = filter_read (4096)) < 0;

          return $status unless $status > 0;

          my $doc = PPI::Document->new (\$_) or Carp::confess "Source could not be understood by PPI";

          $doc = $class->ppi_filter ($doc,@args);

          Carp::confess "$class->ppi_filter did not return a document"
            unless Scalar::Util::blessed $doc && $doc->isa ('PPI::Document');

          $_ = $doc->serialize;

          return $status;
        });
    };
  }

  return;
}

1;

=pod

=head1 NAME

Filter::PPI - PPI based source filtering

=head1 SYNOPSIS

  package MyFilter;

  use Filter::PPI;

  sub ppi_filter {
    my ($class,$doc) = @_;

    # Do funny things to $doc here

    return $doc;
  }

  package MyModule;

  use MyFilter;

  # This will get filtered

=head1 DESCRIPTION

This module  lets you write perl source  filters using  PPI to process
the source. Compared to other modules used for writing source filters,
it is  quite simple. You  only need to  have one method in your class,
called ppi_filter. This gets passed the class name, a L<PPI::Document>
object, and any arguments  given to import.  The method is expected to
return  a  L<PPI::Document> but  not  neccesarily  the same  one.  The
document returned  will be what's used by perl to compile the program.

=head1 SEE ALSO

=over 4

=item L<Filter::Util::Call>

=item L<PPI>

=back

=head1 BUGS

Most software has bugs. This module probably isn't an exception. 
If you find a bug please either email me, or add the bug to cpan-RT.

=head1 AUTHOR

Anders Nor Berle E<lt>berle@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Anders Nor Berle.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

