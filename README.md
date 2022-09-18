# MI BILLS Application by MiCrators

### About the application
MI Bills is a multiplatform application that built to ease the task of vendors and to provide an efficient transaction mechanism. Its Features includes:  

- Operator authentication with username password an POS_ID
- Transaction History
- Customer Registration for new customer
- Selection From Multiple Warranties 
- Transaction and Bill Registration
- Email Bill to the customer
- Email end of stock to the vendor

Future scope include: 

- Employee benefits on authorizing transactions because the number of transactions by operator are stored.
- Email customer about end of warranty. There is table that stores when the warranty will end for the product along with the owner details, so there we can email when warranty end date is near.

### How to run the application:

Before we run the application, please make sure you hae the following installed:
1. NodeJS, can be downloaded from [Download NodeJS from here](https://nodejs.org/en/download/).
2. MySQL community edition: [Download MySQL from here](https://dev.mysql.com/downloads/mysql/)
3. Flutter: [Download Flutter from here](https://docs.flutter.dev/get-started/install?gclsrc=ds&gclsrc=ds) 
4. Android Studio: [Download Android Studio from here](https://developer.android.com/studio?gclsrc=ds&gclsrc=ds)
5. VS CODE: [Download VS CODE from here](https://code.visualstudio.com/download)
6. Flutter Plugin in Android Studio: [Instruction](https://docs.flutter.dev/get-started/editor?tab=androidstudio)
7. Git: [Git Download](https://git-scm.com/downloads)

Once You have them downloaded We can proceed further:

<p align="center">
  <img height="400" src="/documentation Images/clone_repo.gif" />
</p>

1. Clone this repo with the `git clone https://github.com/ArmanNawaz/BTAttendance` in terminal/cmd/bash.
2. Start the MySQL Command Line Client
2. Open MySQL Terminal and login.
3. Open MySQL Workbench and connect to MySQL.  
<p align="center">
  <img height="400" src="/documentation Images/mysql_workbench_1.png" />
</p>  

4. Open the database.sql (inside the backend folder) from the cloned folder and copy and paste the whole thing in the text area of your workbench. Run by pressing the Lightning icon above.

<p align="center">
  <img height="400" src="/documentation Images/mysql_workbench_2.png" />
</p>  

5. Open terminal and enter the cloned repo by executing `cd MiCrators-MI-Billing-App` from the folder where you have cloned.
6. Now from there go to the backend by executing `cd backend` in the terminal.
7. Run `npm install`
8. Run the backedn with the command `node index.js` or `npm start` in the terminal.
9. Open project in Android Studio.
10. Run get dependencies.  

<p align="center">
  <img height="400" src="/documentation Images/get_dependencies.png" />
</p>  

11. Select the platform and run the application.  

Emulator can be downloaded from:
<p align="center">
  <img height="400" src="/documentation Images/install_emulator.gif" />
</p>


# Using the application 

#### Authentication 
There are 6 operators we have entered as dummy data with username as operator1, operator2,... operator6 and password as password. If you look at the database you can see the password are hashed before saving and hence are verified when requested form the backend.  
We would recommend to login with the username: **operator6** and password **password** and POS ID as **DLH_01_01_3SDK34**. This POS ID denotes, city name Delhi, area id 01 and machine no: 01.   
After login you can see the operator details are fetched and showed on id card. If you open the terminal than you can see the the stock of the store are fetched and the previous transaction if any shows up in the previous transaction area.  
If the transactions are loaded, the **New Transaction** button on the PC platform or the "**+**" floating action button are orange otherwise they remain grey or a LOADING text is shown.  

#### New Transaction
Let's perform a new payment. Now you can either generate the serial no by scanning the barcode with button provided or type it manually. You can scan on the following barcodes provided. However, we recommend to type it manually.
Type the serial no: '00000000001' (10 times '0' and one time '1'). The details will be shown below for the item including the warranties available. This item will only be present for the store with **MI STORE 4** where Operator6 works. You can view other serial no from the database. Select a warranty and press Add item.  
You can add an another item with the serial no: '00000000018' (9 times 0 and '18'). 

### Checkout Page
In the checkout page enter the phone no: 1234567890, which is an existing dummy data for a customer. The details of the customer will fill the below checkboxes. However you register your own number, so that you can get the email of the bill. Press Confirm Payment and you will receive an email if the transaction is successfull.  
In you MySQL CLI, execute `SELECT * FROM TRANSACTION;` to see the transaction record. 
`SELECT * FROM BILL where transaction_id = (transaction_id from transaction table);` to see the items of the bill.
Also `SELECT * from Stock where SOLD = 1;` to see the sold items and `Select * from active_warranty;` to see when is the warranty ending for the product.


