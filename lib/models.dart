
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