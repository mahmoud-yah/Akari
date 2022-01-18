const express = require('express');
const app = express();
const port = 3000 || process.env.PORT;
const Web3 = require('web3');
const truffle_connect = require('./connection/app.js');
const bodyParser = require('body-parser');

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));

// parse application/json
app.use(bodyParser.json());

app.use('/', express.static('public_static'));

app.get('/getAccounts', (req, res) => {
  console.log("**** GET /getAccounts ****");
  truffle_connect.start(function (answer) {
    res.send(answer);
  })
});

app.get('/api/accounts', (req, res) => {
  console.log("**** GET /getAccounts ****");
  truffle_connect.start(function (answer) {
    console.log(answer);
    res.status(200).send({
      success:true,
      accounts:answer,
    });
  })
});

//get one account
app.get('/api/accounts/:id', (req, res) => {
  console.log("**** GET /getAccounts ****");
  truffle_connect.start(function (answer) {
    console.log(answer[req.params.id]);
    res.status(200).send({
      success:true,
      account:answer[req.params.id],
    });
  })
});


//get account balance
app.get('/api/balance/:id', (req, res) => {
  console.log("**** GET /getAccounts ****");

  var web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

  truffle_connect.start(function (answer) {
    console.log(answer[req.params.id]);
    var balance = web3.eth.getBalance(answer[req.params.id]);
    var etherBalance = web3.fromWei(balance,'ether');
    res.status(200).send({
      success:true,
      account:answer[req.params.id],
      balance:balance,
      Balance_in_ether:etherBalance,
    });
  })
});


//get transaction number
app.get('/api/transaction/number/:id', (req, res) => {
  console.log("**** GET /getAccounts ****");
  var web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

  truffle_connect.start(function (answer) {
    console.log(answer[req.params.id]);
    var transactionCount = web3.eth.getTransactionCount(answer[req.params.id]);
    res.status(200).send({
      success:true,
      account:answer[req.params.id],
      Num_of_Transactions:transactionCount
    });
  })
});


//get Tx Hash
app.get('/api/tx/hash/:id', (req, res) => {
  console.log("**** GET /getAccounts ****");
  var web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

  truffle_connect.start(function (answer) {
    console.log(answer[req.params.id]);
    var txHash = web3.eth.getTransaction('0x2f39c604be37dff497e5e0ffb2d3e9d578a5cefcbf9030486d8619dde21e41f0');
    res.status(200).send({
      success:true,
      account:answer[req.params.id],
      tx_Hash:txHash
    });
  })
});




//get private key
app.get('/api/privatekey/:id', (req, res) => {
    var web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

  truffle_connect.start(function (answer) {
    var accountPrivateKey = web3.eth.accounts.privateKeyToAccount(answer[req.params.id]);

    console.log(answer[req.params.id]);
    res.status(200).send({
      success:true,
      account:answer[req.params.id],
      accountPrivateKey:accountPrivateKey,
    });
  })
});




app.post('/getBalance', (req, res) => {
  console.log("**** GET /getBalance ****");
  console.log(req.body);
  let currentAcount = req.body.account;

  truffle_connect.refreshBalance(currentAcount, (answer) => {
    let account_balance = answer;
    truffle_connect.start(function(answer){
      // get list of all accounts and send it along with the response
      let all_accounts = answer;
      response = [account_balance, all_accounts]
      res.send(response);
    });
  });
});




//get owner info
app.get('/api/get/owner', (req, res) => {
  truffle_connect.getOwner( (answer) => {
     // res.send(answer);
      res.status(200).send({
        success:true,
        First_Name:answer[0],
        Last_Name:answer[1],
        Father_Name:answer[2],
        Mother_Name:answer[3],
        National_Number:answer[4],
      });
      console.log(answer);

    });
});



//set owner
app.post('/api/set/firstname/:id', (req, res) => {
  console.log(req.body);

  var web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

  let firstname = req.body.firstname;
  let lastname = req.body.lastname;
  let fathername = req.body.fathername;
  let mothername = req.body.mothername;
  let nationalNumber = req.body.nationalNumber;
  // let description = req.body.description;
  // let price = web3.utils.toWei(req.body.price,'ether');


  truffle_connect.start(function (answer) {
    console.log(answer);
    console.log(answer[req.params.id]);
    truffle_connect.setOwner(answer[req.params.id],firstname,lastname,fathername,mothername,nationalNumber, (answer) => {
      res.send(answer);
    });
  })

});






//get book info
app.get('/api/get/book', (req, res) => {
  truffle_connect.getBook( (answer) => {
      res.send(answer);
    });
});



//sell book
app.post('/api/sell/book/:id', (req, res) => {
  console.log(req.body);

  var web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

  let fullname = req.body.fullname;
  let description = req.body.description;
  let price = web3.utils.toWei(req.body.price,'ether');


  truffle_connect.start(function (answer) {
    console.log(answer[req.params.id]);
    truffle_connect.sellBook(answer[req.params.id],fullname, description, price, (answer) => {
      res.send(answer);
    });
  })

});








app.post('/sendCoin', (req, res) => {
  console.log("**** GET /sendCoin ****");
  console.log(req.body);

  let amount = req.body.amount;
  let sender = req.body.sender;
  let receiver = req.body.receiver;

  truffle_connect.sendCoin(amount, sender, receiver, (balance) => {
    res.send(balance);
  });
});


app.listen(port, () => {

  // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
  truffle_connect.web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

  console.log("Express Listening at http://localhost:" + port);

});
