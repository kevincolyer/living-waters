                                  @z=
                               ('5;086',
                             '5;079','5;057'
                          ,'5;072', '5;073',
                         '5;069','5;018','5;036'
                       , '5;039','5;038','5;031'
                      , '5;023','5;025',  '5;033',
                     '5;027',  '5;026',    '5;153',
                   '5;110',  '5;105','5;117','5;109',
                 '5;111', '5;074', '5;099',   '5;061' ,   
               '5;075',  '5;068', '5;067','5;017','5;159',
             '5;066','5;063','5;084','5;083','5;078');$R=22
            ;$M=$R-3;@S;$S[$_]=' 'for(0..$M**2); @ds=([-1,0],
            [0,1],[1,0],[0,-1]);for$p(0..$M**2){($x,$y)=T($p)
           ;$x+=$M/2;$y+=$M/2;next if$x<0or$y<0or$x>$M||$y>$M;
          $p2c[$p]=[$x,$y]}sub T{$x=0;$y=0;$p=shift;$i=0;$L=1;
          $l=$L;$d=0; while($i<$p) {$x+=$ds[$d][0]; $y+=$ds[$d]
          [1];$l--;$i++;if($l==0){ $L++if($d)%2;$l=$L;$d=($d+1)
          %4}}($x,$y)}@B;sub X{print "\033[2J\033[0;0H";($x,$y);
          $B[$_]=  []for(0..$M+1);for(0..$#S){next if ! defined
          $p2c[$_]; ($x,$y)= @{$p2c[$_]}; $B[$y][$x]=$S[$_]}for
           $y(0..$R) {print join " ",@{$B[$y]}if defined$B[$y];
           print"\n"} print"\e[m"}@b ;$ndx=0; $tg=0; @w=qw{the
            water I give will become in you a spring of water 
             welling up to eternal life}; $I=sub {if (@b==0) 
              {@b=split//,$tg?" "x(rand(5)+2):$w[$ndx];$ndx
               +=$tg;$tg++;$tg%=2;$ndx=0if$ndx==@w}$r=$b[0]
                =~/\s/?'':"\e[38;".$z[rand@z]."m";$r.shift
                  @b}; use Time::HiRes "usleep";while (1)
                       {unshift@S,$I->();pop@S;X();
                            usleep((1+rand.5)*
                                 100000) }