//    This script is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This script is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
//    Created by: Luke Calderon
//    Version: 1.0
//    Date: 29 July 2020

EVENT INQ:1
    
    var discChkTtl:$5       //Decimal variable for total amount for discount
    discChkTtl = 0          //Set the variable to 0
    
    var discPerGst:$5       //Decimal variable for discount per guest
    discPerGst = 0          //Zero the discount

    var FiftyPercDisc:$5    //Decimal for the 50% discount calc
    FiftyPercDisc = 0       //Set to 0
    
    var maxDisc:$5          //Decimal for the max check discount (number of guests * Â£10)
    maxDisc = 0             //Set to 0
    
    var discRefInfo:A30     //String variable for ref info on Check
    discRefInfo = ""        //Blank it out
    
    var validDays:A5        //List of valid days
    validDays = "1,2,3"     //Set to Monday, Tuesday and Wednesday
    
    var currentDay:A1       //Current day number
    currentDay = @WEEKDAY   //Set to current day
    
    var validMonths:A5      //List of valid months
    validMonths = "8"       //Set to August (month 8)
    
    var currentMonth:A1     //Current month number
    currentmonth = @MONTH   //Set to current month

    
    var i:N5                //Variable for check detail lines
    
    //Check if the discount is valid today
    if (instr(1, validDays, currentDay))
        
        //Check to see if discount is valid this month
        if (instr(1, validMonths, currentMonth))
            //Discount is valid
        else
            exitwitherror "Discount is not valid this month!"
        endif
        
        //Check that the guest count is greater than 0
        if (@GST > 0)
            //Guest count is fine
        else
            exitwitherror "Guest count must be greater than 0 for this discount to apply"
        endif
        
    
        //Loop through check detail lines. Repeat elseif block for every discount itemiser you want to apply this to
        for i = 1 to @NUMDTLT         
            //waitforclear "Number Detail Lines: ", @NUMDTLT //Debugging
            if @dtl_type[i] = "M" and @dtl_dsci[i] = 1          //If it's a menu item, and has Food Discount Itemizer
                //waitforclear "Item ", @dtl_name[i], " is applicable for discount"
                discChkTtl = discChkTtl + @dtl_ttl[i]
            elseif @dtl_type[i] = "M" and @dtl_dsci[i] = 12     //If it's a menu item, and has Non Alc Bev Discount Itemizer
                //waitforclear "Item ", @dtl_name[i], " is applicable for discount"
                discChkTtl = discChkTtl + @dtl_ttl[i]
            endif
        endfor
        
        //Check if the discount has already been applied
        for i = 1 to @NUMDTLT
            if @dtl_type[i] = "T" and @dtl_objnum[i] = 8015     //If it's a tender line and object #8015
                exitwitherror "Discount already applied!"
            endif
        endfor
        
        //Show total applicable for discount an also number of guests
        waitforclear "Total applicable for discount: ", discChkTtl, ". Number of Guests: ", @GST
        
        //Check if 50% off is over the cap
        discPerGst = discChkTtl / @GST      //Calculate discount per guest (Discountable Check Total / Number of Guests)
        FiftyPercDisc = (discChkTtl * 0.5)  //50% Discount Calculation (Discountable Check Total * 0.5)
        maxDisc = (@GST * 10.00)            //Calculate maximum discount per guest (Number of Guests * Â£10.00)
        
        //waitforclear "Discount per head: Â£", discPerGst //Debugging
        
        //Is 50% discount over the Â£10 Cap? If not, use the 50% rule. Else use the Â£10 Cap Rule
        if FiftyPercDisc <= maxDisc
            discChkTtl = FiftyPercDisc
                //waitforclear "Discount Rule 50% - Total Amount: Â£", discChkTtl //Debugging
            discPerGst = discChkTtl / @GST
            //format discRefInfo as "50% Discount - (", @GST, "x Â£", discPerGst, ")"
            format discRefInfo as "50% Discount"
        elseif discPerGst > 10.00
            discPerGst = 10.00
            discChkTtl = maxDisc
            //waitforclear "Discount is Â£10 per person - Total Amount: Â£", discChkTtl //Debugging
            //format discRefInfo as "Â£10 Discount - (", @GST, "x Â£10.00)"
            format discRefInfo as "Â£10 Discount"
        endif
        
        //Search for the discount NLU 1002, then press enter, type the discount amount, press enter, type in the ref info, press enter
        clearkybdmacro
        //loadkybdmacro key(11,202), makekeys(8015), @KEY_ENTER, makekeys(discChkTtl), @KEY_ENTER
        loadkybdmacro defkey("Payment", N:8015, A:"Cash:Cash"), makekeys(discChkTtl), @KEY_ENTER
    else
        exitwitherror "Discount is not valid today"
    endif
    
ENDEVENT
    
    
    //Use for debugging by assigning a SIM Inquiry key to EOTHO_Discount:2
EVENT INQ:2
    
    var discChkTtl:$5       //Decimal variable for total amount for discount
    discChkTtl = 0          //Set the variable to 0
    
    var discPerGst:$5       //Decimal variable for discount per guest
    discPerGst = 0          //Zero the discount

    var FiftyPercDisc:$5    //Decimal for the 50% discount calc
    FiftyPercDisc = 0       //Set to 0
    
    var maxDisc:$5          //Decimal for the max check discount (number of guests * Â£10)
    maxDisc = 0             //Set to 0
    
    var discRefInfo:A30     //String variable for ref info on Check
    discRefInfo = ""        //Blank it out
    
    var validDays:A5        //List of valid days
    validDays = "1,2,3"     //Set to Monday, Tuesday and Wednesday
    
    var currentDay:A1       //Current day number
    currentDay = @WEEKDAY   //Set to current day
    
    var validMonths:A5      //List of valid months
    validMonths = "8"       //Set to August (month 8)
    
    var currentMonth:A1     //Current month number
    currentmonth = @MONTH   //Set to current month

    
    var i:N5                //Variable for check detail lines
    
    //Check if the discount is valid today
    if (instr(1, validDays, currentDay))
        
        //Check to see if discount is valid this month
        if (instr(1, validMonths, currentMonth))
            //Discount is valid
        else
            exitwitherror "Discount is not valid this month!"
        endif
        
        //Check that the guest count is greater than 0
        if (@GST > 0)
            //Guest count is fine
        else
            exitwitherror "Guest count must be greater than 0 for this discount to apply"
        endif
        
    
        //Loop through check detail lines. Repeat elseif block for every discount itemiser you want to apply this to
        for i = 1 to @NUMDTLT         
            //waitforclear "Number Detail Lines: ", @NUMDTLT //Debugging
            if @dtl_type[i] = "M" and @dtl_dsci[i] = 1          //If it's a menu item, and has Food Discount Itemizer
                //waitforclear "Item ", @dtl_name[i], " is applicable for discount"
                discChkTtl = discChkTtl + @dtl_ttl[i]
            elseif @dtl_type[i] = "M" and @dtl_dsci[i] = 12     //If it's a menu item, and has Non Alc Bev Discount Itemizer
                //waitforclear "Item ", @dtl_name[i], " is applicable for discount"
                discChkTtl = discChkTtl + @dtl_ttl[i]
            endif
        endfor
        
        //Check if the discount has already been applied
        for i = 1 to @NUMDTLT
            if @dtl_type[i] = "T" and @dtl_objnum[i] = 8015     //If it's a tender line and object #8015
                exitwitherror "Discount already applied!"
            endif
        endfor
        
        //Show total applicable for discount an also number of guests
        waitforclear "Total applicable for discount: ", discChkTtl, ". Number of Guests: ", @GST
        
        //Check if 50% off is over the cap
        discPerGst = discChkTtl / @GST      //Calculate discount per guest (Discountable Check Total / Number of Guests)
        FiftyPercDisc = (discChkTtl * 0.5)  //50% Discount Calculation (Discountable Check Total * 0.5)
        maxDisc = (@GST * 10.00)            //Calculate maximum discount per guest (Number of Guests * Â£10.00)
        
        //waitforclear "Discount per head: Â£", discPerGst //Debugging
        
        //Is 50% discount over the Â£10 Cap? If not, use the 50% rule. Else use the Â£10 Cap Rule
        if FiftyPercDisc <= maxDisc
            discChkTtl = FiftyPercDisc
                //waitforclear "Discount Rule 50% - Total Amount: Â£", discChkTtl //Debugging
            discPerGst = discChkTtl / @GST
            //format discRefInfo as "50% Discount - (", @GST, "x Â£", discPerGst, ")"
            format discRefInfo as "50% Discount"
        elseif discPerGst > 10.00
            discPerGst = 10.00
            discChkTtl = maxDisc
            //waitforclear "Discount is Â£10 per person - Total Amount: Â£", discChkTtl //Debugging
            //format discRefInfo as "Â£10 Discount - (", @GST, "x Â£10.00)"
            format discRefInfo as "Â£10 Discount"
        endif
        
        //Search for the discount NLU 1002, then press enter, type the discount amount, press enter, type in the ref info, press enter
        clearkybdmacro
        //loadkybdmacro key(11,202), makekeys(8015), @KEY_ENTER, makekeys(discChkTtl), @KEY_ENTER
        loadkybdmacro defkey("Payment", N:8015, A:"Cash:Cash"), makekeys(discChkTtl), @KEY_ENTER
    else
        exitwitherror "Discount is not valid today"
    endif
    
ENDEVENT
