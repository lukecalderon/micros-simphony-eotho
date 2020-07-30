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
![](https://i.imgur.com/KqnHcKc.png)

2. Set the following under the **General** tab
    - Configuration Section
        - Activation Type - Manual
        - Percent - 0
        - Max Amount - 0
        - Enabled - Ticked
        - Tax Class - All Taxes
    - Trigger Section
        - Trigger MI Group - Use Discount Itemizers
    - Options Section
        - Options 1, 2, 5, 11, 25 - Ticked
 ![](https://i.imgur.com/bztjVFy.png)
 
 3. Set the following under the **Effectivity** tab
    - Effectivity Section
         - Start Date - 01 August 2020
         - End Date - 31 August 2020
    -  Recurrence Day of Week
         - Monday, Tuesday, Wednesday - Ticked
![](https://i.imgur.com/MPmNlbB.png)

4. Set the following under the **Itemizers** tab
    - Computer on Discountable Itemizers Section
        - 1, 12 - Ticked  *Choose the correct itemizers for your setup. If different to mine, you will need to modify the script slightly to make sure it discounts the items*
![](https://i.imgur.com/Kil5NN0.png)

5. Set the following under the **NLU/SLU** tab
    - Display Settings Section
        - NLU - 1002 *You can change this, but again will need to modify the script so that it types the correct NLU when searching*
![](https://i.imgur.com/2VCXQDp.png)

6. OPTIONAL - Set the following under the **Output** tab
    - Options Section
        - Print on Customer Receipt - Ticked
        - Print on Journal - Ticked
        - Print on Guest Check - Ticked 
![](https://i.imgur.com/1UbUNwM.png)

7. **SAVE**


### Configure the Extension Application
1. From the tree menu, either select Enterprise Level or Property Level to create the application

2. Click the **New** button at the top of the screen to create a new Extension Applicaiton, and then create it as follows:
    - Name: EOTHO_Discount
    - Description: EOTHO_Discount
!()[https://i.imgur.com/w7JARsg.png]

3. Double click on the Extension Application, and then under the **General** tab, click **Insert Application Content**
!()[https://i.imgur.com/KtLYBGM.png]

4. Configure the file as follows:
    - ZoneableKey: EOTHO
    - Description: Anything Useful
!()[https://i.imgur.com/gBXoRwi.png]

5. Set the **Option Bits** on the file (click the ... button, then enable option 2), and set the **Disk File Name** to **EOTHO.isl**
!()[https://i.imgur.com/8Sdszyc.png]

6. Double Click on the EOTHO file, and then set the following
    - Content Type: 19 - Sim Script
    - File Name Origin: EOTHO.isl
    - Content: Paste the contents of EOTHO.isl from this repo
!()[https://i.imgur.com/szLRHfW.png]

7. **SAVE**

8. For this new extension application to be found on the workstations, you will need to either restart the ServiceHost application, or if easier restart the whole till.

### Configure the Extension Application
1. Create a new button under **Page Design** with the following settings:
    - Legend: Name of the button (I used ***Eat Out to Help Out Discount***)
    - Type: Function / Sim Inquite
    - Arguments: EOTHO_Discount:1
!()[https://i.imgur.com/j9OYEQ8.png]

2. **SAVE**

That should leave you with a working discount!

### Screenshots
50% Discount Rule:

![](https://i.imgur.com/H7NWy9F.png)


£10 Discount Rule:

![](https://i.imgur.com/1ZNUQU4.png)
