#! /usr/bin/env perl
use Modern::Perl;
use Time::HiRes "usleep";
use Term::ExtendedColor qw(:all);
no warnings;

END { say clear() };

my @blues=qw(
  aquamarine1      deepskyblue4    lightsteelblue3
  aquamarine3      deepskyblue4    lightsteelblue
  blueviolet       dodgerblue1     navyblue
  cadetblue1       dodgerblue2     paleturquoise1
  cadetblue2       dodgerblue3     paleturquoise4
  cornflowerblue   lightskyblue1   royalblue1
  darkblue         lightskyblue3   seagreen1
  darkcyan         lightskyblue3   seagreen2
  deepskyblue1     lightslateblue  seagreen3
  deepskyblue2     lightsteelblue1 skyblue1
  deepskyblue3     slateblue1      steelblue 
  skyblue2         slateblue3      steelblue3
  skyblue3         steelblue1      
  );

my $COLS=`tput cols`;
my $ROWS=`tput lines`;
$COLS=$ROWS=22; # !!!!!! JUST FOR TESTING
my $MAX=$ROWS-3;
# $MAX=$ROWS-1 if $ROWS<$COLS;
my @spiral;
$spiral[$_]=' ' for (0..($MAX*$MAX));


my @directions=( [-1,0],[0,1],[1,0],[0,-1] ); #W,S,E,N

die test() if @ARGV  && $ARGV[0] =~m/test/i;

my @point2xycache;
for my $p (0..$MAX*$MAX) {
  my ($x,$y) = map_point_2_xy($p);
    $x+=$MAX/2;
    $y+=$MAX/2;
    next if $x < 0 or $y < 0 or $x > $MAX or $y > $MAX; # truncate to display
  
  $point2xycache[$p]=[$x,$y];
}
sub map_point_2_xy {
  my $x=0;
  my $y=0;
  my $p = shift;
  my $i=0;
  my $len=1;
  my $l=$len;
  my $dir=0;
  while ($i<$p) {
    $x+=$directions[$dir][0];
    $y+=$directions[$dir][1];
    $l--;
    $i++;
    if ($l==0) {
      $len++ if ($dir) % 2 ;
      $l=$len;
      $dir= ($dir +1) % 4;
    }
  }
  return ($x,$y);
}

sub display2 {
print "\033[2J";    #clear the screen
print "\033[0;0H"; #jump to 0,0
   state @bitmap;
   my ($x,$y);
  $bitmap[$_]=[] for (0..$MAX+1);
  for (0..$#spiral) {
    next if !defined $point2xycache[$_];
    ($x,$y)=@{$point2xycache[$_]};
    $bitmap[$y][$x]=$spiral[$_];
  }
  for my $y (0..$ROWS) {
    print join " ", @{$bitmap[$y]} if defined $bitmap[$y];
    print "\n";
  }
  clear();
}

my @words=qw{the water I give will become in you a spring of water welling up to eternal life};
my $iter = sub {
  state @buffer;
  state $i=0;
  state $toggle=0;
  if (@buffer==0) {
    @buffer= split //, $toggle 	? 
	" " x (rand(5)+2) 	: 
	$words[$i];
    $i+=$toggle;
    $toggle++;
    $toggle %= 2;
    $i=0 if $i==@words;
  }
  my $ret = $buffer[0]=~/\s/ ? 
		    ''       :
		    fg( $blues[rand @blues] );
  return $ret. shift @buffer;
};

# main loop
while (1) {
  unshift @spiral, $iter->(); pop @spiral;
  display2();
  usleep ((1+rand 0.5)*100_000);
}
###################################
sub test {
  my @points= ( 
  4,3,2,1,0,
  9,8,7,6,9,
  0,1,0,5,8,
  1,2,3,4,7,
  2,3,4,5,6, );
#test directions
  use Test::More ;
  my @pointlist=(0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,) ;
#   for my $p (0..24) {
  for my $p (0..24) {
      my ($x,$y)=map_point_2_xy($p);
      my $pval=$points[$x+2+($y+2)*5];
      is($pval,$p % 10, "$x,$y, maps to point $p ok");
  }  
done_testing;
};