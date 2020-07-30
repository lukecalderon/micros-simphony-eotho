EVENT INQ:1
    
    var discChkTtl:$5       //Decimal variable for total amount for discount
    discChkTtl = 0          //Set the variable to 0
    
    var discPerGst:$5       //Decimal variable for discount per guest
    discPerGst = 0          //Zero the discount

    var FiftyPercDisc:$5    //Decimal for the 50% discount calc
    FiftyPercDisc = 0       //Set to 0
    
    var maxDisc:$5          //Decimal for the max check discount (number of guests * £10)
    maxDisc = 0             //Set to 0
    
    var discRefInfo:A30     //String variable for ref info on Check
    discRefInfo = ""        //Blank it out
    

    
    var i:N5                //Variable for check detail lines
    
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
    
    
    //Show total applicable for discount an also number of guests
    waitforclear "Total applicable for discount: ", discChkTtl, ". Number of Guests: ", @GST
    
    //Check if 50% off is over the cap
    discPerGst = discChkTtl / @GST      //Calculate discount per guest (Discountable Check Total / Number of Guests)
    FiftyPercDisc = (discChkTtl * 0.5)  //50% Discount Calculation (Discountable Check Total * 0.5)
    maxDisc = (@GST * 10.00)            //Calculate maximum discount per guest (Number of Guests * £10.00)
    
    //waitforclear "Discount per head: £", discPerGst //Debugging
    
    //Is 50% discount over the £10 Cap? If not, use the 50% rule. Else use the £10 Cap Rule
    if FiftyPercDisc <= maxDisc
        discChkTtl = FiftyPercDisc
            //waitforclear "Discount Rule 50% - Total Amount: £", discChkTtl //Debugging
        discPerGst = discChkTtl / @GST
        format discRefInfo as "50% Discount - (", @GST, "x £", discPerGst, ")"
    elseif discPerGst > 10.00
        discPerGst = 10.00
        discChkTtl = maxDisc
        //waitforclear "Discount is £10 per person - Total Amount: £", discChkTtl //Debugging
        format discRefInfo as "£10 Discount - (", @GST, "x £10.00)"
    endif
    
    //Search for the discount NLU 1002, then press enter, type the discount amount, press enter, type in the ref info, press enter
    clearkybdmacro
    loadkybdmacro key(11,200), makekeys(1002), @KEY_ENTER, makekeys(discChkTtl), @KEY_ENTER, makekeys(discRefInfo), @KEY_ENTER

    
    ENDEVENT
