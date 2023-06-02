##############################################################################
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : <unknown>
#  Created       : Wed May 24 19:38:04 2023
#  Last Modified : <230524.2044>
#
#  Description	
#
#  Notes
#
#  History
#	
##############################################################################
#
#  Copyright (c) 2023 <unknown>.
# 
#  All Rights Reserved.
# 
#  This  document  may  not, in  whole  or in  part, be  copied,  photocopied,
#  reproduced,  translated,  or  reduced to any  electronic  medium or machine
#  readable form without prior written consent from <unknown>.
#
##############################################################################


set code "x=1
println(x)
y=x+1
println(y)
println(z)
x=x+2
println(x)
l = \[\"Hello\" \"Julia\" \"World!\"\]
      
for i in l
   println(i)
end
using PyPlot
ioff();
x = range(0, 1, length=20)
y = x .^ 2
plot(x, y)
savefig(\"jpipe.png\")
println(\"Done!\")        
"

proc piperead {pipe args} {
    if {![eof $pipe]} {
        set got [gets $pipe]
        if {$got ne ""} {
            puts stdout "$got"
            flush stdout
        }
    } elseif {[fblocked $pipe]} {
        # No output
        break
    } else {
        close $pipe
    }
}

set pipe [open "|julia 2>@1" r+]
fconfigure $pipe -buffering none -blocking false
fileevent $pipe readable [list piperead $pipe]
set rwait [list]
foreach rline [split $code \n] {
    puts $pipe $rline
    puts $pipe "flush(stdout)"
    flush $pipe
    if {[regexp {^[^\s]} $rline]} {
        puts "julia> $rline"
    } else {
        puts "       $rline"
    }
    flush stdout
    # need some delay for the pipe
    after 1000 [list append rwait ""]
    vwait rwait
}
