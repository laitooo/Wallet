
class Record {
  int id;
  String name;
  int currency;
  double credit;
  double debit;
  double balance;

  Record(this.id, this.name, this.currency, this.credit, this.debit, this.balance);

  factory Record.fromMap(Map<String, dynamic> data){
    return Record(data["id"], data["name"], data["currency"], data["credit"],
        data["debit"], data["balance"]);
  }

  factory Record.fromDynamic(dynamic data){
    return Record(data["id"], data["name"], data["currency"], data["credit"],
        data["debit"], data["balance"]);
  }

  Map<String, dynamic> toMap() =>{
    "id" : id,
    "name" : name,
    "currency" : currency,
    "credit" : credit,
    "debit" : debit,
    "balance" : balance,
  };
}

class Transaction {
  int id;
  String title;
  String date;
  double credit;
  double debit;


  Transaction(this.id, this.title, this.date, this.credit, this.debit);

  factory Transaction.fromMap(Map<String, dynamic> data){
    return Transaction(data["id"], data["title"], data["date"], data["credit"],
        data["debit"]);
  }

  factory Transaction.fromDynamic(dynamic data){
    return Transaction(data["id"], data["title"], data["date"], data["credit"],
        data["debit"]);
  }

  Map<String, dynamic> toMap() =>{
    "id" : id,
    "title" : title,
    "date" : date,
    "credit" : credit,
    "debit" : debit,
  };
}