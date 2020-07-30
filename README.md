# Micros Simphony SIM Script - Eat Out to Help Out Scheme
## Overview
SIM Script &amp; Detail on how to setup the UK Government Eat Out to Help Out discount on Micros Simphony (Version 2.7 +)

### Reason for this script
There is no clear way that a single discount setting in Simphony (on the version that I use) can handle both the 50% discount rule and cap it at £10 per person. This means you would need to have two buttons for two different discounts, (one for 50%, one for £10) and rely on the waiter/waitress to select the correct discount and click on it the correct number of times.

### What this script does
- Loops through each check detail line (including condiments)
- Checks to see if the detail line it's currently processing is a Menu Item, and if the Discount Itemiser of the Menu Item Class matches 1 or 12 (1 = Food, 12 = Non-Alcoholic Beverage, which may be different in your system)
- If so, it adds the value of said item to a culumative running total value which it will apply the discount to
- Calculates the discountable amount per guest (using the Guest Count Value on the check)
- Calculates the value of 50% of the discountable amount (Discountable Amount * 0.5)
- Calculates the maximum discount per guest (Number of Guests * £10.00)
- Checks to see if the 50% discount amount is lower than the maximum discountable amount
- If yes, it calculates the value per guest to print on the receipt, and stores the 50% discount amount ready to discount from the check
- If not, it calculates the maximum discount per guest, and stores this amount ready to discount from the check
- It then uses a Discount NLU lookup to find the EOTHO discount that is configured, and types the discount amount in, enters the reference info containing what rule it is applying (£10 per guest or 50%), and then presses enter
- The check can then be service totaled or taken

### How to use the script at the till
- Add the menu items as required
- Set the number of guests for the check
- Press the discount button (linked to the script)
- Proceed to service total/tender the check


## Installing the Extension Application & Linking to a Page
### Configure the discount
1. Create a discount at Enterprise or Property Level (a discount set at enterprise level will inherit to property)
!(https://i.imgur.com/KqnHcKc.png)
