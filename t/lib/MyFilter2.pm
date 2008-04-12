package MyFilter2;

use Filter::PPI;

sub ppi_filter {
  my ($class,$doc) = @_;

  my $element = $doc->find_first ('PPI::Token::Number');

  $element->insert_after (PPI::Token::Number->new (84));

  $element->remove;

  return $doc;
}

1;

