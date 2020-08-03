# Micros Simphony SIM Script - Eat Out to Help Out Scheme
## Overview
SIM Script &amp; Detail on how to setup the UK Government Eat Out to Help Out discount on Micros Simphony (Version 2.7 +)

### Reason for this script
There is no clear way that a single discount setting in Simphony (on the version that I use) can handle both the 50% discount rule and cap it at £10 per person. This means you would need to have two buttons for two different discounts, (one for 50%, one for £10) and rely on the waiter/waitress to select the correct discount and click on it the correct number of times. Due to HMRC requiring the business to pay the full amount of tax on items pre-discount, and we have our tenders coming through to our PMS, we must partially tender the check to handle the discount. 

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
- It then uses a defkey to simulate a Payment Key, finds the configured tender object number and types the discount amount in and then presses enter
- The check can then be service totaled or payment taken

### How to use the script at the till
- Add the menu items as required
- Set the number of guests for the check
- Press the discount button (linked to the script)
- Proceed to service total/tender the check


## Installing the Extension Application & Linking to a Page
### Configure the tender media
1. Create a new tender media at enterprise level, and take note of the object number (in our case, it is 8015)

![](https://i.imgur.com/xNxOOcz.png)


2. Under the **Options** Tab, set the following settings
    - **Printing Options**
        - Suggested options: 8, 20, 21, 23, 24, 28, 54

![](https://i.imgur.com/bYLAF4u.png)


    - **Interface Options**
        - Interface Link: Your PMS Interface link (if you do not post to a PMS, leave this blank)
        - Options: 29, 31, 38

![](https://i.imgur.com/nAwCJZ1.png)


    - **Ops Behaviour**
        - Amount Options Section: Option 2 (Amount Required) - Ticked
        - General Options Section: Option 48 (Item is Shareable) - Ticked

![](https://i.imgur.com/5vqOXgq.png)


3. **SAVE**


### Configure the Extension Application
1. From the tree menu, either select Enterprise Level or Property Level to create the application

2. Click the **New** button at the top of the screen to create a new Extension Applicaiton, and then create it as follows:
    - Name: EOTHO_Discount
    - Description: EOTHO_Discount
![](https://i.imgur.com/w7JARsg.png)

3. Double click on the Extension Application, and then under the **General** tab, click **Insert Application Content**
![](https://i.imgur.com/KtLYBGM.png)

4. Configure the file as follows:
    - ZoneableKey: EOTHO
    - Description: Anything Useful
![](https://i.imgur.com/gBXoRwi.png)

5. Set the **Option Bits** on the file (click the ... button, then enable option 2), and set the **Disk File Name** to **EOTHO.isl**
![](https://i.imgur.com/8Sdszyc.png)

6. Double Click on the EOTHO file, and then set the following
    - Content Type: 19 - Sim Script
    - File Name Origin: EOTHO.isl
    - Content: Paste the contents of EOTHO.isl from this repo
![](https://i.imgur.com/szLRHfW.png)

7. **SAVE**

8. For this new extension application to be found on the workstations, you will need to either restart the ServiceHost application, or if easier restart the whole till.

### Configure the Extension Application
1. Create a new button under **Page Design** with the following settings:
    - Legend: Name of the button (I used ***Eat Out to Help Out Discount***)
    - Type: Function / Sim Inquite
    - Arguments: EOTHO_Discount:1
![](https://i.imgur.com/j9OYEQ8.png)

2. **SAVE**

That should leave you with a working discount!

### Screenshots
50% Discount Rule - 2 Guests:

![](https://i.imgur.com/H7NWy9F.png)


£10 Discount Rule - 1 Guest:

![](https://i.imgur.com/1ZNUQU4.png)
