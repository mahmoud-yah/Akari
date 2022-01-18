const contract = require('truffle-contract');

const metacoin_artifact = require('../build/contracts/MetaCoin.json');
var MetaCoin = contract(metacoin_artifact);

const bookstore_artifact = require('../build/contracts/BookStore.json');
var BookStore = contract(bookstore_artifact);

const owner_artifact = require('../build/contracts/Owner.json');
var Owner = contract(owner_artifact);


module.exports = {
  start: function(callback) {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    MetaCoin.setProvider(self.web3.currentProvider);
    BookStore.setProvider(self.web3.currentProvider);

    // Get the initial account balance so it can be displayed.
    self.web3.eth.getAccounts(function(err, accs) {
      if (err != null) {
        console.log("There was an error fetching your accounts.");
        console.log(err);
        return;
      }

      if (accs.length == 0) {
        console.log("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
        return;
      }
      self.accounts = accs;
      self.account = self.accounts[2];

      callback(self.accounts);
    });
  },




  sellBook: function(sender,fullname, description, price, callback) {
    var self = this;


    BookStore.setProvider(self.web3.currentProvider);

    var meta;
    BookStore.deployed().then(function(instance) {
      meta = instance;
      return meta.sellBook(fullname, description, price, {from: sender});
    }).then(function() {
      self.getBook(function (answer) {
        callback(answer);
      });
    }).catch(function(e) {
      console.log(e);
      callback("ERROR 404");
    });
  },



  getBook: function(callback) {
    var self = this;
    BookStore.setProvider(self.web3.currentProvider);

    var meta;
    BookStore.deployed().then(function(instance) {
      meta = instance;
      return meta.getBook.call();
    }).then(function(value) {
        callback(value);
    }).catch(function(e) {
        console.log(e);
        callback("Error 404");
    });
  },


  getOwner: function(callback) {
    var self = this;
    Owner.setProvider(self.web3.currentProvider);

    var meta;
    Owner.deployed().then(function(instance) {
      meta = instance;
      return meta.getInfo();
      //return meta.test.call();
    }).then(function(value) {
        callback(value);
    }).catch(function(e) {
        console.log(e);
        callback("Error 404");
    });
  },




  setOwner: function(sender, firstname,lastname,fathername,mothername,nationalNumber, callback) {
    var self = this;


    Owner.setProvider(self.web3.currentProvider);

    var meta;

    Owner.deployed().then(function(instance) {
      meta = instance;
      return meta.setInfo(firstname,lastname,fathername,mothername,nationalNumber, {from: sender});
    }).then(function() {
      self.getOwner(function (answer) {
        callback(answer);
      });
    }).catch(function(e) {
      console.log(e);
      callback("ERROR 404");
    });
  },




  refreshBalance: function(account, callback) {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    MetaCoin.setProvider(self.web3.currentProvider);

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.getBalance.call(account, {from: account});
    }).then(function(value) {
        callback(value.valueOf());
    }).catch(function(e) {
        console.log(e);
        callback("Error 404");
    });
  },

  sendCoin: function(amount, sender, receiver, callback) {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    MetaCoin.setProvider(self.web3.currentProvider);

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.sendCoin(receiver, amount, {from: sender});
    }).then(function() {
      self.refreshBalance(sender, function (answer) {
        callback(answer);
      });
    }).catch(function(e) {
      console.log(e);
      callback("ERROR 404");
    });
  }
}
